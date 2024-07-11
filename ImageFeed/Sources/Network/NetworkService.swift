//
//  NetworkService.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import Foundation

protocol ImageNetworkService {
    func fetchImages(pagination: [PexelsAPI.Query.Pagination]) async throws -> Images
}