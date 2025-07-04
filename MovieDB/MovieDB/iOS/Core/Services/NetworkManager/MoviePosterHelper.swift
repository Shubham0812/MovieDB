//
//  MoviePosterHelper.swift
//  MovieDB
//
//  Created by Shubham on 01/07/25.
//

import SwiftUI

enum MoviePosterHelper {
    static let baseURL = "https://image.tmdb.org/t/p/"
    
    static func posterURL(path: String?, size: ImageSize = .w500) -> URL? {
        url(for: path, size: size)
    }
    
    static func backdropURL(path: String?, size: ImageSize = .w780) -> URL? {
        url(for: path, size: size)
    }

    private static func url(for path: String?, size: ImageSize) -> URL? {
        guard let path = path else { return nil }
        return URL(string: baseURL + size.rawValue + path)
    }

    enum ImageSize: String {
        case original
        case w200, w300, w500, w780, w1280
    }
}
