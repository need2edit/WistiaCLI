//
//  API.swift
//  WistiaCLI
//
//  Created by Jake Young on 6/12/17.
//  Copyright © 2017 Jake young. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var version: String { get }
}

extension Endpoint {
    var versionedPath: String {
        return version + path
    }
}

protocol APIService {
    associatedtype Route: Endpoint
    static var baseURL: URL { get }
}

extension APIService {
    static func url(route: Route, queryParams: [String: String] = [:]) -> URL {
        var components = URLComponents(url: Self.baseURL, resolvingAgainstBaseURL: true)
        components?.path = route.versionedPath
        components?.queryItems = [
            URLQueryItem(name: "api_password", value: "1234567890")
        ]
        return components!.url!
    }
}
