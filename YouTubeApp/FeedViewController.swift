//
//  ViewController.swift
//  YouTubeApp
//
//  Created by Alex Yatsenko on 26.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let dataFetcherManager = DataFetcherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataFetcherManager.fetchVideos { result in
            switch result {
            case .success(let videos):
                print(videos.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

