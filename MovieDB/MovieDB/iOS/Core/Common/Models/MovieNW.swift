//
//  Network.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import Foundation
import SwiftUI

class MovieNW: ObservableObject, Identifiable, Decodable, Hashable {
    static func == (lhs: MovieNW, rhs: MovieNW) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id: Int64
    let title: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let totalVotes: Int?
    let genres: [Int]
    
    @Published var isFavorite: Bool

    var genreIDs: String? {
        genres.map(String.init).joined(separator: ",")
    }

    init(id: Int64, title: String?, overview: String?, posterPath: String?, backdropPath: String?, releaseDate: String?, voteAverage: Double, totalVotes: Int? = nil, genres: [Int] = [], isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.totalVotes = totalVotes
        self.genres = genres
        self.isFavorite = isFavorite
    }

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case totalVotes = "vote_count"
        case genres = "genre_ids"
        case isFavorite
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.init(
            id: try container.decode(Int64.self, forKey: .id),
            title: try container.decodeIfPresent(String.self, forKey: .title),
            overview: try container.decodeIfPresent(String.self, forKey: .overview),
            posterPath: try container.decodeIfPresent(String.self, forKey: .posterPath),
            backdropPath: try container.decodeIfPresent(String.self, forKey: .backdropPath),
            releaseDate: try container.decodeIfPresent(String.self, forKey: .releaseDate),
            voteAverage: try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0,
            totalVotes: try container.decodeIfPresent(Int.self, forKey: .totalVotes),
            genres: try container.decodeIfPresent([Int].self, forKey: .genres) ?? [],
            isFavorite: try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
        )
    }
}

extension MovieNW: MovieListData {}
