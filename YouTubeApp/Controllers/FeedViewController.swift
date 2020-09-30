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
        collectionView.backgroundColor = .systemBackground
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
        setupNavigationBar()
        setupCollectionView()
        getVideosData()
    }
    
    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .systemBackground
        navBarAppearance.shadowColor = .systemBackground
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.hidesBarsOnSwipe = true
        let imageView = UIImageView(image: Image.youTubeTitle)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
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
        videosCollectionView.delegate = self
        view.addSubview(videosCollectionView)
        videosCollectionView.fillSuperview()
        
        let registration = UICollectionView.CellRegistration<VideoCell, Video> { (cell, _, video) in
            cell.dataFetcherManager = self.dataFetcherManager
            cell.video = video
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Video>(
            collectionView: videosCollectionView, cellProvider: { (collectionView, indexPath, video) in
                collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: video)
            }
        )
    }
    
}

extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let cell = collectionView.cellForItem(at: indexPath) as? VideoCell
        if let video = cell?.video {
            detailVC.video = video
            present(detailVC, animated: true)
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}
