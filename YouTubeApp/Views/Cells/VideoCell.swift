//
//  VideoCell.swift
//  YouTubeApp
//
//  Created by Alex Yatsenko on 30.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

final class VideoCell: UICollectionViewListCell {
    
    private let dateLabel = UILabel()
    
    private let videoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "play.rectangle.fill"))
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor,
                                         multiplier: 1280/720).isActive = true
        imageView.tintColor = .red
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let dataFetcherManager = DataFetcherManager()
    private var thumbnailURLString: String? { didSet { getThumbnail(for: thumbnailURLString) } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with video: Video) {
        titleLabel.text = video.title
        if let published = video.published {
            dateLabel.text = published.toString(format: "EEEE, MMM d, yyyy")
        }
        thumbnailURLString = video.thumbnail
    }
    
    private func setupViews() {
        let cellStackView = UIStackView(
            arrangedSubviews: [videoImageView, titleLabel, dateLabel]
        )
        cellStackView.spacing = 10
        cellStackView.axis = .vertical
        addSubview(cellStackView)
        cellStackView.fillSafeArea()
    }
    
    private func getThumbnail(for urlString: String?) {
        dataFetcherManager.fetchThumbnail(for: urlString) { [weak self] result in
            switch result {
            case .success(let imageData):
                if self?.thumbnailURLString == urlString,
                   let image = UIImage(data: imageData) {
                    self?.videoImageView.image = image
                } else {
                    self?.videoImageView.image = UIImage(systemName: "play.rectangle.fill")
                }
            case .failure(let error):
                print("Failed to get thumbnail", error.localizedDescription)
            }
        }
    }
}
