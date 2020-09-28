//
//  NetworkManager.swift
//  YouTubeApp
//
//  Created by Alex Yatsenko on 27.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    private let session = URLSession.shared
    
    func requestVideosData(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: API.apiURLString) else { return }
        session.dataTask(with: url) { (data, response, error) in
            if let networkError = error {
                completion(.failure(networkError))
                return
            } else if (response as? HTTPURLResponse)?.statusCode == 200,
                      let videoData = data {
                completion(.success(videoData))
            }
        }.resume()
    }
}
