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
    
    private let imageView = UIImageView()
    private let authorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupShadowAndCorners()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 40
//        imageView.layer.shadowColor = UIColor.black.cgColor
//        imageView.layer.shadowOpacity = 0.5
//        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        imageView.layer.shadowRadius = 4
        
        authorLabel.textColor = .white
        authorLabel.font = .monospacedDigitSystemFont(ofSize: 24, weight: .thin)
        authorLabel.textAlignment = .center
        authorLabel.backgroundColor = .black.withAlphaComponent(0.5)
        authorLabel.layer.cornerRadius = 15
        authorLabel.clipsToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(authorLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
//            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
//            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
//            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60),
            authorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            authorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            authorLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupShadowAndCorners() {
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 10
//        layer.masksToBounds = false
        
        // Enable rasterization to improve performance
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath
    }
    
//    func setupConstraints(){
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            
//            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//            authorLabel.heightAnchor.constraint(equalToConstant: 20)
//        ])
        
//            imageView.anchor(top: contentView.topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: contentView.leadingAnchor, paddingLeft: 0, right: contentView.trailingAnchor, paddingRight: 0, width: 0, height: 0)
//            authorLabel.anchor(top: imageView.bottomAnchor , paddingTop: 5, bottom: contentView.bottomAnchor, paddingBottom: -5, left: contentView.leadingAnchor, paddingLeft: 5, right: contentView.trailingAnchor, paddingRight: -5, width: 0, height: 0)
//        }
    
    // TODO: Check
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        imageView.removeFromSuperview()
//        authorLabel.removeFromSuperview()
//        
//    }
    
    func configure(with image: Image) {
        authorLabel.text = image.photographer.uppercased()
        imageView.kf.setImage(with: URL(string: image.src.large)) { result in
            if case .success(let value)  = result {
                ImageCache.default.store(value.image, forKey: image.src.large) // TODO: check cache
            }
        } // TODO: think about kingsfisher here {
    }
}
