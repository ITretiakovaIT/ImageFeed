//
//  ImageNetworkService.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import Foundation
import Alamofire

extension PexelsAPI: ImageNetworkService {
    func fetchImages(page: Int, pagination: [Query.Pagination]) async throws -> [Image] {
        let endPoint = PexelsAPI.Endpoint.curatedPhotos
        let queryItems: [URLQueryItem] = pagination.map { $0.urlQueryItem }
        
        return try await get(
            APIParams<Empty, [Image]>(
                endPoint: endPoint,
                query: queryItems
            )
        )
    }
}
