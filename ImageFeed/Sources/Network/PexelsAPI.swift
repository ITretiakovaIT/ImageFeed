//
//  PexelsAPI.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import Foundation
import Alamofire

struct PexelsAPI {
    static let baseURL = "https://api.pexels.com/v1/"
    var apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
}

extension PexelsAPI: APIRequests {
    func get <Input: Codable, Output: Codable>(_ params: APIParams<Input, Output>) async throws -> Output {
        let url = createURL(endPoint: params.endPoint, queryParams: params.query)
        let httpHeaders = createHeaders()
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: .get,
                parameters: params.body,
                encoder: JSONParameterEncoder.default,
                headers: httpHeaders
            ).responseDecodable(of: Output.self) { response in
                switch response.result {
                case .success(let output):
                    continuation.resume(returning: output)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

private extension PexelsAPI {
    func createHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = ["Authorization": apiKey]
        return headers
    }
    
    func createURL(endPoint: String, queryParams: [URLQueryItem]?) -> String {
        let url = PexelsAPI.baseURL + endPoint
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = queryParams
        return urlComponents?.string ?? url
    }
}
