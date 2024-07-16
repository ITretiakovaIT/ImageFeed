//
//  UIImageView+Blur.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 16.07.2024.
//

import CoreImage
import UIKit

extension UIImageView {
    private static var blurCache = NSCache<NSString, UIImage>()
    private static var context = CIContext()

    func setBlurEffect(radius: CGFloat) {
        guard let image = self.image else { return }

        let cacheKey = "\(image.hashValue)-\(radius)" as NSString
        if let cachedImage = UIImageView.blurCache.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            guard let ciImage = CIImage(image: image) else { return }

            let filter = CIFilter(name: Constants.gaussianFilterName)
            filter?.setValue(ciImage, forKey: kCIInputImageKey)
            filter?.setValue(radius, forKey: kCIInputRadiusKey)

            guard let outputImage = filter?.outputImage else { return }
            guard let cgImage = UIImageView.context.createCGImage(outputImage, from: ciImage.extent) else { return }

            let blurredImage = UIImage(cgImage: cgImage)
            UIImageView.blurCache.setObject(blurredImage, forKey: cacheKey)

            DispatchQueue.main.async {
                self.image = blurredImage
            }
        }
    }
    
    private struct Constants {
        static let gaussianFilterName = "CIGaussianBlur"
    }
}
