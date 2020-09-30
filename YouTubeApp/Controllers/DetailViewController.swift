//
//  DetailViewController.swift
//  YouTubeApp
//
//  Created by Alex Yatsenko on 30.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import WebKit

final class DetailViewController: UIViewController {
    
    private let dateLabel = UILabel()
    var video: Video?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let videoWebView: WKWebView = {
        let webView = WKWebView()
        webView.widthAnchor.constraint(equalTo: webView.heightAnchor,
                                       multiplier: 1280/720).isActive = true
        return webView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 17)
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func setupViews() {
        let detailStackView = UIStackView(
            arrangedSubviews: [titleLabel, dateLabel, videoWebView, descriptionTextView]
        )
        detailStackView.axis = .vertical
        detailStackView.spacing = 10
        view.addSubview(detailStackView)
        detailStackView.anchors(top: view.topAnchor,
                                leading: view.leadingAnchor,
                                trailing: view.trailingAnchor,
                                bottom: view.bottomAnchor,
                                padding: .init(top: 50, left: 20, bottom: 20, right: 20))
    }
    
    private func updateUI() {
        titleLabel.text = video?.title
        descriptionTextView.text = video?.description
        if let date = video?.published {
            dateLabel.text = date.toString(format: DateFormatString.full)
        }
        if let videoId = video?.videoId {
            let embedURLString = API.embedURLString + videoId
            if let url = URL(string: embedURLString) {
                videoWebView.load(URLRequest(url: url))
            }
        }
    }

}
