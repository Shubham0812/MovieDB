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
    case defaultCategory
}

extension Movie {
    convenience init(context: NSManagedObjectContext, category: MovieCategory, from movie: MovieNW, isFavorite: Bool = false) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context) else {
            fatalError("Couldn’t find entity 'Movie' in context")
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.id = movie.id
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
        self.category = category.rawValue
        self.genreIDs = movie.genres.map(String.init).joined(separator: ",")
        self.isFavorite = isFavorite
        
        self.totalVotes = Int64(movie.totalVotes ?? 0)
        self.voteAverage = movie.voteAverage
        
        self.timestamp = Date().timeIntervalSince1970
        self.backdropPath = movie.backdropPath
        self.posterPath = movie.posterPath
    }
}


extension Movie: MovieListData {

}
