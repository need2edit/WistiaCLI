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
    let description: String?
    let mediaCount: Int
    let created: String
    let updated: String
    let hashedId: String?
    let anonymousCanUpload: Bool
    let anonymousCanDownload: Bool
    let publicId: String
}

struct ProjectDetails: Codable {
    let id: Int
    let name: String
    let description: String
    let mediaCount: Int
    let created: String
    let updated: String
    let hashed_Id: String
    let anonymousCanUpload: Bool
    let anonymousCanDownload: Bool
    let publicId: String
    let medias: [Media]?
}
