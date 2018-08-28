//
//  NetworkManager.swift
//  NasaApp
//
//  Created by Anthony Tulai on 2018-08-28.
//  Copyright © 2018 Anthony Tulai. All rights reserved.
//

import Foundation
import UIKit

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    static let timeoutInterval: Double = 7.0 //In seconds
    
    func request(url: String, requestMethod: RequestMethod = .get, errorHandler: @escaping (_ error: Error) -> Void, successHandler: @escaping (_ json: Any) -> Void) -> URLSessionDataTask? {
        
        guard let url = URL(string: url), UIApplication.shared.canOpenURL(url) else {
            return nil
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: NetworkManager.timeoutInterval)

        request.httpMethod = requestMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    errorHandler(error)
                }
                
                if let data = data {
                    successHandler(data)
                }
            }
        })
        dataTask.resume()
        return dataTask
    }

}
