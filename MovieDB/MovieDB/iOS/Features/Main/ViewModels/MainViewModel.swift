//
//  MainViewModel.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import SwiftUI
import CoreData

/// ViewModel responsible for fetching, storing and managing movie data from network and Core Data
final class MainViewModel: ObservableObject {
    
    // MARK: - Dependencies
    let networkManager: NetworkManager
    
    // MARK: - Published Properties (UI Binding)
    @Published var searchedMovies: [MovieNW] = []               // Movies from search
    @Published var weeklyTopTenMovies: [MovieNW] = []           // Weekly trending top 10 movies
    @Published var dailyTrendingMovies: [MovieNW] = []          // Daily trending movies
    
    @Published var topRatedMovies: [MovieNW] = []               // Top rated movies from API
    @Published var popularMovies: [MovieNW] = []                // Popular movies from API
    
    @Published var errorMessage: String?                        // To show error to user
    @Published var featuredMovie: MovieNW?                      // Random featured movie (used in UI)
    
    @Published var favoriteMovieIDs: [Int64] = []
    
    @Published var selectedMovies: [MovieNW] = []
    
    // MARK: - Core Data Context
    var modelContext: NSManagedObjectContext?
    var coreDataService: CoreDataService?
     
    // MARK: - Initializer
    init(networkManager: NetworkManager = .init()) {
        self.networkManager = networkManager
    }
    
    // MARK: - Load Core Data Context & Fetch Existing Movies
    func loadData(modelContext: NSManagedObjectContext) {
        self.modelContext = modelContext
        self.coreDataService = .init(context: modelContext)
     
        loadFavoriteMovies()
    }
    
    func loadFavoriteMovies() {
        let movies = coreDataService?.fetch(Movie.self) ?? []
        self.favoriteMovieIDs = movies.map { $0.id }
    }
    
    // MARK: - Fetch Trending Movies (Daily)
    @MainActor
    func fetchTopRatedMovies(page: Int) async {
        let result = await networkManager.request(.topRated(page: page), as: TopRatedMoviesResponse.self)
        switch result {
        case .success(let success):
            var movies = success.results
            for ix in movies.indices {
                if favoriteMovieIDs.contains(movies[ix].id) {
                    movies[ix].isFavorite = true
                }
            }
            self.topRatedMovies = movies
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
        
        // Randomly select one as featured movie
        self.featuredMovie = topRatedMovies.randomElement()
    }
    
    @MainActor
    func fetchTrendingMovies() async {
        let result = await networkManager.request(.trending(period: TrendingMovie.day.rawValue), as: MovieSearchResponse.self)
        switch result {
        case .success(let response):
            self.dailyTrendingMovies = response.results
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - Fetch Weekly Top 10 Movies
    @MainActor
    func fetchWeeklyTopTenMovies() async {
        let result = await networkManager.request(.trending(period: TrendingMovie.week.rawValue), as: MovieSearchResponse.self)
        switch result {
        case .success(let response):
            self.weeklyTopTenMovies = Array(response.results.prefix(10))
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - Fetch Top Rated Movies
  
    
    // MARK: - Fetch Popular Movies
    @MainActor
    func fetchPopularMovies(page: Int) async {
        let result = await networkManager.request(.popular(page: page), as: PopularMoviesResponse.self)
        switch result {
        case .success(let success):
            self.popularMovies = success.results
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - Get Movie Detail
    @MainActor
    func getMovieDetails(_ movieID: Int64) async -> MovieDetail? {
        let result = await networkManager.request(.movieDetail(id: movieID), as: MovieDetail.self)
        switch result {
        case .success(let detail):
            return detail
        case .failure(let error):
            self.errorMessage = error.localizedDescription
            return nil
        }
    }
    
    // MARK: - Get Cast Information for a Movie
    @MainActor
    func getCastDetails(_ movieID: Int64) async -> [CastMember] {
        let result = await networkManager.request(.movieCredits(id: movieID), as: MovieCreditsResponse.self)
        switch result {
        case .success(let response):
            return response.cast
        case .failure(let error):
            self.errorMessage = error.localizedDescription
            return []
        }
    }

    // MARK: - Save a Movie as Favorite (Core Data)
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
    
    // MARK: - Unfavorite a Movie (Set isFavorite to false)
    func unfavoriteMovie(movieID: Int64) {
        guard let movie = coreDataService?.fetch(Movie.self, predicate: NSPredicate(format: "id == %d", movieID)).first else { return }
        
        movie.isFavorite = false
        coreDataService?.save()
    }
}

extension MainViewModel {
    func movies(for category: MovieCategory) -> [MovieNW] {
        switch category {
        case .topRated: return topRatedMovies
        case .popular: return popularMovies
        case .trendingDaily: return dailyTrendingMovies
        case .trendingWeekly: return weeklyTopTenMovies
        }
    }
}
