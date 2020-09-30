//
//  VideoCell.swift
//  YouTubeApp
//
//  Created by Alex Yatsenko on 30.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

final class VideoCell: UICollectionViewListCell {
    
    private var thumbnailURLString: String? { didSet { getThumbnail(for: thumbnailURLString) } }
    var dataFetcherManager: DataFetcherManager?
    var video: Video? { didSet { updateUI() } }
    private let dateLabel = UILabel()
    
    private let videoImageView: UIImageView = {
        let imageView = UIImageView(image: Image.cellPlaceholder)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let cellStackView = UIStackView(
            arrangedSubviews: [videoImageView, titleLabel, dateLabel]
        )
        cellStackView.spacing = 10
        cellStackView.axis = .vertical
        addSubview(cellStackView)
        cellStackView.fillSuperview(with: 20)
    }
    
    private func updateUI() {
        titleLabel.text = video?.title
        if let date = video?.published {
            dateLabel.text = date.toString(format: DateFormatString.full)
        }
        thumbnailURLString = video?.thumbnail
    }
    
    private func getThumbnail(for urlString: String?) {
        dataFetcherManager?.fetchThumbnail(for: urlString) { [weak self] result in
            switch result {
            case .success(let imageData):
                if self?.thumbnailURLString == urlString,
                   let image = UIImage(data: imageData) {
                    self?.videoImageView.image = image
                } else {
                    self?.videoImageView.image = Image.cellPlaceholder
                }
            case .failure(let error):
                print("Failed to get thumbnail", error.localizedDescription)
            }
        }
    }
}
