//
//  VideosResponse.swift
//  YouTubeApp
//
//  Created by Alex Yatsenko on 28.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

struct VideosResponse: Decodable {
    
    let items: [Video]?
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([Video].self, forKey: .items)
    }
}
