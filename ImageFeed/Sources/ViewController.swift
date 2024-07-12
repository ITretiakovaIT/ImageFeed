//
//  ViewController.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let api = PexelsAPI(apiKey: Config().pexelsAPIKey)
        Task {
            do {
                let imgs = try await api.fetchImages(pagination: [.page(value: 1), .limit(value: 10)])
                print(imgs)
            } catch {
                Logger.errorDebugLog(error.localizedDescription, category: .Network)
            }
        }
    }

}

