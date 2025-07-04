//
//  MovieResponse.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import SwiftUI

struct MovieSearchResponse: Decodable {
    let page: Int
    let results: [MovieNW]
    let totalResults: Int
    let totalPages: Int

    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

