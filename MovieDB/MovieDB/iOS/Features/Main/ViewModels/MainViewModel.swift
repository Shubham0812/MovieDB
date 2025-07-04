//
//  MainViewModel.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import SwiftUI
import CoreData

final class MainViewModel: ObservableObject, APIUpdatable {
    
    // MARK: - Variables
    let networkManager: NetworkManager
    
    
    @Published var searchedMovies: [MovieNW] = []
    
    @Published var weeklyTopTenMovies: [MovieNW] = []
    @Published var dailyTrendingMovies: [MovieNW] = []
    
    @Published var topRatedMovies: [MovieNW] = []
    @Published var popularMovies: [MovieNW] = []
    
    @Published var errorMessage: String?
    
    @Published var featuredMovie: MovieNW?
    
    var modelContext: NSManagedObjectContext?
    var coreDataService: CoreDataService?
    
    
    // MARK: - Inits
    init(networkManager: NetworkManager = .init()) {
        self.networkManager = networkManager
    }
    
    
    // MARK: - Functions
    func loadData(modelContext: NSManagedObjectContext) {
        self.modelContext = modelContext
        self.coreDataService = .init(context: modelContext)
        
        
        let movies = coreDataService!.fetch(Movie.self)
        
        print("FETCHED MOVIES", movies)
    }
    
    @MainActor
    func fetchTrendingMovies() async {
        let result = await networkManager.request(.trending(period: TrendingMovie.day.rawValue), as: MovieSearchResponse.self)
        await MainActor.run {
            apply(result.map(\.results), to: \.dailyTrendingMovies)
        }
    }
    
    @MainActor
    func fetchWeeklyTopTenMovies() async {
        let result = await networkManager.request(.trending(period: TrendingMovie.week.rawValue), as: MovieSearchResponse.self)
        await MainActor.run {
            apply(result.map(\.results), transform: { Array($0.prefix(10)) }, to: \.weeklyTopTenMovies)
        }
    }
    
    
    
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
    
    
    // Top Rated Movies
    @MainActor
    func fetchTopRatedMovies(page: Int) async {
        let result = await networkManager.request(.topRated(page: page), as: TopRatedMoviesResponse.self)
        await MainActor.run {
            apply(result.map(\.results), to: \.topRatedMovies)
            
            self.featuredMovie = topRatedMovies.randomElement()
        }
    }
    
    // Popular Movies
    @MainActor
    func fetchPopularMovies(page: Int) async {
        let result = await networkManager.request(.popular(page: page), as: PopularMoviesResponse.self)
        await MainActor.run {
            apply(result.map(\.results), to: \.popularMovies)
        }
    }
    
    func saveMovie(movieNW: MovieNW) {
        guard let modelContext else { return }
        
        let movie: Movie = Movie(context: modelContext, category: .topRated, from: movieNW, isFavorite: true)
        modelContext.insert(movie)
        
        coreDataService?.save()
    }
    
    func unfavoriteMovie(movieID: Int64) {
        guard let movie = coreDataService?.fetch(Movie.self, predicate: NSPredicate(format: "id == %d", movieID)).first else { return }
        
        movie.isFavorite = false
        coreDataService?.save()
    }
}

