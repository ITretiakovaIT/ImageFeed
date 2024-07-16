//
//  ImageDetailViewController.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import UIKit
import Kingfisher

class DetailImageViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DetailImageViewModel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var fullSizeImageView: UIImageView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        // Load background image with Kingfisher (used already cached img URL from coll view cell)
        backgroundImage.kf.setImage(with: URL(string: viewModel.backgroundImageURL))
        // Apply blur effect to background image
        self.backgroundImage.setBlurEffect(radius: 5)
    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
