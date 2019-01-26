//
//  URL.swift
//  LifeHacksApp
//
//  Created by zombietux on 14/01/2019.
//  Copyright © 2019 zombietux. All rights reserved.
//

import Foundation

extension URL {
    func appendingParameters(_ parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        var queryItems = urlComponents.queryItems ?? []
        for key in parameters.keys {
            queryItems.append(URLQueryItem(name: key, value: parameters[key]))
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}
