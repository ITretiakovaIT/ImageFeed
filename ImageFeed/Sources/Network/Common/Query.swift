//
//  Query.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import Foundation

protocol QueryFilterable {
    var stringKey: String { get }
    var stringValue: String { get }
    
    var urlQueryItem: URLQueryItem { get }
}

extension QueryFilterable {
    var urlQueryItem: URLQueryItem {
        return URLQueryItem(name: stringKey, value: stringValue)
    }
}

extension PexelsAPI {
    struct Query {
        enum Pagination: QueryFilterable {

            case page(value: Int)
            case limit(value: Int)

            var stringKey: String {
                switch self {
                case .limit: return "perPage"
                case .page: return "page"
                }
            }

            var stringValue: String {
                switch self {
                case .limit(let value): return "\(value)"
                case .page(let value): return "\(value)"
                }
            }
        }
    }
}
