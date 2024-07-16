//
//  DetailImageViewModel.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 12.07.2024.
//

import UIKit

class DetailImageViewModel {
    
    // MARK: - Properties
    
    var fullSizeImageURL: String
    var backgroundImageURL: String
    
    // MARK: - Initialization
    
    init(fullSizeImageURL: String, backgroundImageURL: String) {
        self.fullSizeImageURL = fullSizeImageURL
        self.backgroundImageURL = backgroundImageURL
    }
}
