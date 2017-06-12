//
//  Media.swift
//  WistiaCLI
//
//  Created by Jake Young on 6/12/17.
//  Copyright © 2017 Jake young. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    let url: URL
    let width: Double
    let height: Double
}

struct Media: Codable {
    
    struct Asset: Codable {
        let url: URL
        let width: Double
        let height: Double
        let fileSize: Int64
        let contentType: String
        let type: String
    }
    
    let id: Int
    let name: String
    let description: String
    
    let type: MediaType
    let status: MediaStatus
    let progress: Double?
    let section: String?
    let thumbnail: Thumbnail
    let duration: Double
    let created: Date
    let updated: Date
    let assets: [Asset]
    let hashed_id: String
    
    enum MediaType: String, Codable {
        case video = "Video"
        case audio = "Audio"
        case image = "Image"
        case pdf = "PdfDocument"
        case microsoftOfficeDocument = "MicrosoftOfficeDocument"
        case swf = "Swf"
        case unknown = "UnknownType"
    }
    
    enum MediaStatus: String, Codable {
        case queued
        case processing
        case ready
        case failed
    }
    
}
