//
//  Config.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import Foundation

struct Config {
    var pexelsAPIKey: String {
        config[Constants.pexelsAPIkeyPropertyName] as! String
    }
    
    private var config: [String: Any]

    init() {
        guard let path = Bundle.main.path(forResource: Constants.plistFileName, ofType: Constants.fileType),
              let xml = FileManager.default.contents(atPath: path),
              let config = try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil) as? [String: Any]
        else {
            fatalError(Constants.errorLoadingPlist)
        }
        
        self.config = config
    }
}

private extension Config {
    struct Constants {
        static let plistFileName = "Config"
        static let fileType = "xcprivacy"
        static let pexelsAPIkeyPropertyName = "PexelsAPIkey"
        static let errorLoadingPlist = "Error loading configuration from Config.xcprivacy"
    }
}
