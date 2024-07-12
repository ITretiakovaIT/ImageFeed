//
//  ImageFeedViewModel.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import Foundation

class ImageFeedViewModel {
    private let apiService: PexelsAPI
    private var images: [Image] = []
    private var currentPage = 1

    init(apiService: PexelsAPI) {
        self.apiService = apiService
    }

    func fetchImages() async throws {
        let paginationQuery: [PexelsAPI.Query.Pagination] = [.page(value: currentPage), .limit(value: 10)]
        
        let imgs = try await apiService.fetchImages(pagination: paginationQuery)
        images.append(contentsOf: imgs.photos)
        currentPage += 1
    }

    func getImage(at indexPath: IndexPath) -> Image {
        return images[indexPath.row]
    }

    func getNumberOfImages() -> Int {
        return images.count
    }
}
