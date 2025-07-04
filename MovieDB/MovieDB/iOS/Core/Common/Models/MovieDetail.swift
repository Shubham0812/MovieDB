//
//  MovieDetail.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import SwiftUI

struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let overview: String?
    let releaseDate: String?
    let runtime: Int?
    let genres: [GenreNW]
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let voteCount: Int

    private enum CodingKeys: String, CodingKey {
        case id, title, overview, genres, runtime
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
