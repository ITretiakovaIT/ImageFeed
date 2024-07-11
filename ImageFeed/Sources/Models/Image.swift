//
//  Image.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import Foundation

struct Images: Codable {
    let photos: [Image]
}

struct Image: Codable {
    let id: Int
    let width: Int
    let height: Int
    let photographer: String
    let src: ImageSrc
}

struct ImageSrc: Codable {
    let original: String
    let large: String
}
