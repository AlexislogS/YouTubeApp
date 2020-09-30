//
//  ViewController.swift
//  YouTubeApp
//
//  Created by Alex Yatsenko on 26.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    
    private let dataFetcherManager: DataFetcherManager
    private var dataSource: UICollectionViewDiffableDataSource<Section, Video>?
    
    private let videosCollectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        return collectionView
    }()
    
    private enum Section {
        case main
    }
    
    init(dataFetcherManager: DataFetcherManager) {
        self.dataFetcherManager = dataFetcherManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        getVideosData()
    }
    
    private func getVideosData() {
        dataFetcherManager.fetchVideos { [weak self] result in
            switch result {
            case .success(let videos):
                self?.populate(with: videos)
                self?.videosCollectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func populate(with videos: [Video]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Video>()
        snapshot.appendSections([.main])
        snapshot.appendItems(videos)
        dataSource?.apply(snapshot)
    }
    
    private func setupCollectionView() {
        
        view.addSubview(videosCollectionView)
        videosCollectionView.fillSuperview()
        
        let registration = UICollectionView.CellRegistration<VideoCell, Video> { (cell, _, video) in
            cell.configure(with: video)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Video>(collectionView: videosCollectionView, cellProvider: { (collectionView, indexPath, video) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: video)
        })
    }
    
}

