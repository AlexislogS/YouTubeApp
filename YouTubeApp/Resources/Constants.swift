//
//  Constants.swift
//  YouTubeApp
//
//  Created by Alex Yatsenko on 27.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

enum API {
    // Please add your own api key
    private static let apiKey = APIKey.key
    
    // You can also add your playlist here
    private static let playlistID = "PLHFlHpPjgk735FGOZW_pfK_Y9QXSEwKE-"
    
    static let apiURLString = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(playlistID)&key=\(apiKey)"
    static let embedURLString = "https://www.youtube.com/embed/"
}

enum Image {
    static let cellPlaceholder = UIImage(systemName: "play.rectangle.fill")
    static let youTubeTitle = UIImage(named: "YouTube title")
}

enum DateFormatString {
    static let full = "EEEE, MMM d, yyyy"
}
