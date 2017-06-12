//
//  StatsAPI.swift
//  WistiaCLI
//
//  Created by Jake Young on 6/12/17.
//  Copyright © 2017 Jake young. All rights reserved.
//

import Foundation

class StatsAPI: APIService {
    
    enum Route: Endpoint {
        case projects
        case project(String)
        case medias
        case media(String)
        
        var path: String {
            switch self {
            case .projects:
                return "/projects"
            case .project(let identifier):
                return "/projects/\(identifier).json"
            case .medias:
                return "/medias"
            case .media(let identifier):
                return "/medias/\(identifier).json"
            }
        }
        
        var version: String {
            return "/v1"
        }
        
        var versionedPath: String {
            return version + path
        }
        
    }
    
    static var baseURL: URL {
        return URL(string: "https://api.wistia.com")!
    }
    
}

extension StatsAPI.Route {
    public static var allValues: [DataAPI.Route] {
        return [.projects, .project("abcdef"), .medias, .project("abcdef")]
    }
}
