//
//  SceneDelegate.swift
//  YouTubeApp
//
//  Created by Alex Yatsenko on 26.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = FeedViewController(dataFetcherManager: DataFetcherManager())
        window?.makeKeyAndVisible()
    }
}

