//
//  DataFetcherManager.swift
//  YouTubeApp
//
//  Created by Alex Yatsenko on 27.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import Foundation

final class DataFetcherManager {
    
    private let networkManager = NetworkManager()
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetchVideos(completion: @escaping (Result<[Video], Error>) -> Void) {
        networkManager.requestVideosData { result in
            switch result {
            case .success(let videosResponseData):
                do {
                    let videosResponse = try self.decoder.decode(VideosResponse.self, from: videosResponseData)
                    if let videos = videosResponse.items {
                        completion(.success(videos))
                    }
                } catch let jsonError {
                    print("JSON error", jsonError.localizedDescription)
                    completion(.failure(jsonError))
                }
            case .failure(let networkError):
                print("Network error", networkError.localizedDescription)
                completion(.failure(networkError))
            }
        }
    }
}
