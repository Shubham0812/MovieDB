//
//  Network.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import SwiftUI

struct MovieNW: Identifiable, Decodable, Hashable {
    let id: Int64
    let title: String?
    let overview: String?
    
    let posterPath: String?
    let backdropPath: String?

    let releaseDate: String?
    var voteAverage: Double = 8
    var totalVotes: Int? = 1000
    var genres: [Int] = [18, 80]
    
    var genreIDs: String? {
        genres.map(String.init).joined(separator: ",")
    }
    
    var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        
        case totalVotes = "vote_count"
        case genres = "genre_ids"
    }
}


extension MovieNW: MovieListData {}
