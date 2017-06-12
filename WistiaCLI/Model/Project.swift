//
//  Project.swift
//  WistiaCLI
//
//  Created by Jake Young on 6/12/17.
//  Copyright © 2017 Jake young. All rights reserved.
//

import Foundation

struct Project: Codable {
    let id: Int
    let name: String
    let description: String
    let mediaCount: Int
    let created: Date
    let updated: Date
    let hashedId: String
    let anonymousCanUpload: Bool
    let anonymousCanDownload: Bool
    let isPublic: Bool
    let publicId: String
    let medias: [Media]?
}

extension Project: CustomStringConvertible {
    
}

