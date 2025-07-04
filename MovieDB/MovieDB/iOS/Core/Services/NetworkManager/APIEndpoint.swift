//
//  APIEndpoint.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import Foundation

enum APIEndpoint {
    case searchMovies(query: String, page: Int = 1)
    case trending(period: String) // "day" or "week"
    case movieDetail(id: Int64)
    case movieCredits(id: Int64)
    case popular(page: Int)
    case topRated(page: Int)
    case genres

    var path: String {
        switch self {
        case .searchMovies:
            return "/search/movie"
        case .trending(let period):
            return "/trending/movie/\(period)"
        case .movieDetail(let id):
            return "/movie/\(id)"
        case .movieCredits(let id):
            return "/movie/\(id)/credits"
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .genres:
            return "/genre/movie/list"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .searchMovies(let query, let page):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        case .popular(let page), .topRated(let page):
            return [URLQueryItem(name: "page", value: "\(page)")]
        default:
            return []
        }
    }
}
