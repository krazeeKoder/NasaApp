//
//  APIManager.swift
//  NasaApp
//
//  Created by Anthony Tulai on 2018-08-28.
//  Copyright © 2018 Anthony Tulai. All rights reserved.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    private let baseNasaUrl = "https://api.nasa.gov/"
    private let apiKey = "NNKOjkoul8n1CH18TWA9gwngW1s1SmjESPjNoUFo"
    private let apiKeyQueryParam = "api_key="
    private let dailyImageEndpoint = "/planetary/apod?"
    
    func constructDailyImageUrl() -> String {
        return baseNasaUrl + dailyImageEndpoint + apiKeyQueryParam + apiKey
    }
}
