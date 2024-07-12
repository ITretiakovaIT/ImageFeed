//
//  AppDelegate.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let config = Config()
        let apiService = PexelsAPI(apiKey: config.pexelsAPIKey)
        let viewModel = ImageFeedViewModel(apiService: apiService)
        let imageFeedVC = ImageFeedCollectionViewController(viewModel: viewModel)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: imageFeedVC)
        window?.makeKeyAndVisible()
        
        return true
    }
}
