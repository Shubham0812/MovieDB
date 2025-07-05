//
//  MovieExtension.swift
//  MovieDB
//
//  Created by Shubham on 03/07/25.
//

import CoreData

enum MovieCategory: String {
    case topRated
    case trendingDaily
    case trendingWeekly
    case popular
    
    var title: String {
        switch self {
        case .topRated:
            return "Top-Rated"
        case .trendingDaily:
            return "Trending Now"
        case .trendingWeekly:
            return "Trending This Week"
        case .popular:
            return "Popular Movies"
        }
    }
}

extension Movie {
    convenience init(context: NSManagedObjectContext, category: MovieCategory, from movie: MovieListData, isFavorite: Bool = false) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context) else {
            fatalError("Couldn’t find entity 'Movie' in context")
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.id = movie.id
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
        self.category = category.rawValue
        self.genreIDs = movie.genreIDs
        self.isFavorite = isFavorite
        
        self.voteAverage = movie.voteAverage
        
        self.timestamp = Date().timeIntervalSince1970
        self.posterPath = movie.posterPath
    }
}

extension Movie: MovieListData {}
