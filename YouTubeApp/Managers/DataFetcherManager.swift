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
    private let cache = URLCache.shared
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
                        DispatchQueue.main.async {
                            completion(.success(videos))
                        }
                    }
                } catch let jsonError {
                    print("JSON error", jsonError.localizedDescription)
                    DispatchQueue.main.async {
                        completion(.failure(jsonError))
                    }
                }
            case .failure(let networkError):
                print("Network error", networkError.localizedDescription)
                DispatchQueue.main.async {
                    completion(.failure(networkError))
                }
            }
        }
    }
    
    func fetchThumbnail(for urlString: String?,
                        completion: @escaping (Result<Data, Error>) -> Void) {
        guard urlString != nil, let imageURL = URL(string: urlString!) else { return }
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {
            if let imageData = self.cache.cachedResponse(for: request)?.data {
                DispatchQueue.main.async {
                    completion(.success(imageData))
                }
            } else {
                self.networkManager.requestThumbnail(for: request) { result in
                    switch result {
                    case .success(let imageData):
                        DispatchQueue.main.async {
                            completion(.success(imageData))
                        }
                    case .failure(let networkError):
                        DispatchQueue.main.async {
                            completion(.failure(networkError))
                        }
                    }
                }
            }
        }
    }
}
