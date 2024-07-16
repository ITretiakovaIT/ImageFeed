//
//  ImageDetailViewController.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import UIKit
import Kingfisher

final class DetailImageViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DetailImageViewModel
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var fullSizeImageView: UIImageView!
    
    // MARK: - Initialization
    
    init(viewModel: DetailImageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        // Load background image with Kingfisher (used already cached img URL from coll view cell)
        backgroundImage.kf.setImage(with: URL(string: viewModel.backgroundImageURL))
        // Load full size image with Kingfisher
        fullSizeImageView.kf.setImage(with: URL(string: viewModel.fullSizeImageURL))
        // Apply blur effect to background image
        backgroundImage.setBlurEffect(radius: 3)
    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
