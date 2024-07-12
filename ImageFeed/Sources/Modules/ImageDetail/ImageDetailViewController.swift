//
//  ImageDetailViewController.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    private let photo: Image

    init(photo: Image) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupImageView()
    }

    private func setupImageView() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        imageView.kf.setImage(with: URL(string: photo.src.original))
        // Load image from photo.src.original (you can use a library like SDWebImage for image loading)
    }
}
