//
//  Video.swift
//  YouTubeApp
//
//  Created by Alex Yatsenko on 27.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import Foundation

struct VideosResponse: Decodable {
    let items: [Video]?
}

struct Video: Decodable, Hashable {
    
    let title: String?
    let videoId: String?
    let description: String?
    let thumbnail: String?
    let published: Date?
    
    enum CodingKeys: String, CodingKey {
        case title, description, videoId
        case thumbnail = "url"
        case published = "publishedAt"
        case snippet
        case thumbnails
        case high
        case resourceId
    }
    
    init(from decoder: Decoder) throws {
        
        // MARK: - Containers
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        // MARK: - Decoding
        
        title = try snippetContainer.decode(String.self, forKey: .title)
        description = try snippetContainer.decode(String.self, forKey: .description)
        published = try snippetContainer.decode(Date.self, forKey: .published)
        thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
    }
}
