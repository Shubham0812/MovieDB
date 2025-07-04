//
//  SearchViewModel.swift
//  MovieDB
//
//  Created by Shubham on 04/07/25.
//

import CoreData

@Observable
final class SearchViewModel {
    
    // MARK: - Variables
    var searchText = "" {
        didSet {
            Task {
                await searchMovies()
            }
        }
    }
    
    var errorMessage: String?
    
    var searchedMovies: [MovieNW] = []
    
    let networkManager: NetworkManager
    var modelContext: NSManagedObjectContext?
    var coreDataService: CoreDataService?
    
    // MARK: - Inits
    init(forTest: Bool = true, networkManager: NetworkManager = .init()) {
        self.networkManager = networkManager
    }
    
    
    // MARK: - Functions
    func updateContext(_ modelContext: NSManagedObjectContext) {
        self.modelContext = modelContext
        self.coreDataService = .init(context: modelContext)
    }
    
    
    @MainActor
    func searchMovies() async {
        let result = await networkManager.request(.searchMovies(query: searchText), as: MovieSearchResponse.self)
        apply(result.map(\.results), transform: { Array($0.filter { $0.posterPath != nil }) }, to: \.searchedMovies)
    }
    
    func favoriteMovie(movieNW: MovieNW) {
        guard let modelContext else { return }
        
        if let movie = coreDataService?.fetch(Movie.self, predicate: NSPredicate(format: "id == %d", movieNW.id)).first {
            movie.isFavorite = true
        } else {
            let movie: Movie = Movie(context: modelContext, category: .topRated, from: movieNW, isFavorite: true)
            modelContext.insert(movie)
        }
        coreDataService?.save()
    }
    
    
    func unfavoriteMovie(movieID: Int64) {
        guard let movie = coreDataService?.fetch(Movie.self, predicate: NSPredicate(format: "id == %d", movieID)).first else { return }
        
        movie.isFavorite = false
        coreDataService?.save()
    }
    
    func fetchFavoriteMovieIDs() -> [Int64] {
        guard let movies = coreDataService?.fetch(Movie.self, predicate: NSPredicate(format: "isFavorite == true")) else { return [] }
        
        return movies.map { $0.id }
    }
}


extension SearchViewModel: APIUpdatable {}
