//
//  APIParams.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import Foundation

struct APIParams<Input: Codable, Output: Codable> {
    var endPoint: String
    var body: Input?
    var query: [URLQueryItem]? = nil
}
