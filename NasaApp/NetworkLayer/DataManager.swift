//
//  DataManager.swift
//  NasaApp
//
//  Created by Anthony Tulai on 2018-08-28.
//  Copyright © 2018 Anthony Tulai. All rights reserved.
//

import Foundation

class DataManager {
    var currentNetworkRequest: URLSessionDataTask?
    var nasaDailyUpdateInfo: NasaDailyUpdateInfo?
    static let shared = DataManager()
    private init() {}
    
    func updateDailyImage(completionHandler: @escaping (_ success: Bool) -> Void) {
        currentNetworkRequest = NetworkManager.shared.request(url: APIManager.shared.constructDailyImageUrl(), requestMethod: .get, errorHandler: { (error) in
            guard error._code != NSURLErrorCancelled else { return }
            self.currentNetworkRequest = nil
            completionHandler(false)
        }) { (jsonData) in
            self.currentNetworkRequest = nil
            self.parseJsonIntoDailyInfo(json: jsonData, completionHandler: completionHandler)
        }
    }
    
    private func parseJsonIntoDailyInfo(json: Any, completionHandler: @escaping (Bool) -> Void) {
        guard let json = json as? Data else { return }
        let decoder = JSONDecoder()
        do {
            self.nasaDailyUpdateInfo = try decoder.decode(NasaDailyUpdateInfo.self, from: json)
            completionHandler(true)
        } catch {
            completionHandler(false)
        }
    }
}
