//
//  ImageFeedCollectionViewCell.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import UIKit
import Kingfisher

class ImageFeedCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ImageFeedCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: PaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        setupShadowAndCorners()
    }
    
    private func setupViews() {
        authorLabel.layer.cornerRadius = 5
        authorLabel.clipsToBounds = true
    }
    
    private func setupShadowAndCorners() {
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        
        layer.masksToBounds = false
        
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 8
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath
    }
    
    func configure(with image: Image) {
        authorLabel.text = image.photographer.uppercased()
        imageView.kf.setImage(with: URL(string: image.src.medium))
    }
}
