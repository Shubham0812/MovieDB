//
//  MovieGenreResponse.swift
//  MovieDB
//
//  Created by Shubham on 03/07/25.
//

import Foundation

struct MovieGenreResponse: Decodable {
    let genres: [GenreNW]
}
