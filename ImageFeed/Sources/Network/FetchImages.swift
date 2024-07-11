//
//  ImageNetworkService.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import Foundation
import Alamofire

extension PexelsAPI: ImageNetworkService {
    func fetchImages(pagination: [Query.Pagination]) async throws -> Images {
        let endPoint = PexelsAPI.Endpoint.curatedPhotos
        let queryItems: [URLQueryItem] = pagination.map { $0.urlQueryItem }
        
        return try await get(
            APIParams<Empty, Images>(
                endPoint: endPoint,
                query: queryItems
            )
        )
    }
}
