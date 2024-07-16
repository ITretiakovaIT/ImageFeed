//
//  APIRequests.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import Foundation

protocol APIRequests {
    func get <Input: Codable, Output: Codable>(_ params: APIParams<Input, Output>) async throws -> Output
}
