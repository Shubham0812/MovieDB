//
//  GenreProvider.swift
//  MovieDB
//
//  Created by Shubham on 04/07/25.
//

import CoreData

class GenreService: ObservableObject {
    private let networkManager: NetworkManager = .init()

    private var modelContext: NSManagedObjectContext?
    private var coreDataService: CoreDataService?

    var genres: [Int64: String] = [:]

    // MARK: - Functions
    func loadData(modelContext: NSManagedObjectContext) {
        self.modelContext = modelContext
        self.coreDataService = .init(context: modelContext)
        
        
        Task {
            await loadGenres()
        }
    }
    
    @MainActor
    func loadGenres() async {
        guard let coreDataService else { return }
        let genres = coreDataService.fetch(Genre.self)
        
        guard genres.isEmpty else {
            self.genres = Dictionary(uniqueKeysWithValues: genres.map { ($0.id, $0.name ?? "") })
            return
        }
        
        let result = await networkManager.request(.genres, as: MovieGenreResponse.self)
        
        do {
            guard let modelContext else { return }
            
            let genres: [GenreNW] = try result.get().genres
            
            genres.forEach {
                let genre: Genre = Genre(context: modelContext, from: $0)
                modelContext.insert(genre)
                
                self.genres[genre.id] = genre.name
            }
            coreDataService.save()
            
        } catch {
            
        }
    }
    
    func getGenres(from genreString: String?) -> String {
        guard let genreString else { return "" }

        let genreIDs: [Int16] = genreString
            .split(separator: ",")
            .compactMap { Int16($0.trimmingCharacters(in: .whitespaces)) }

        return genreIDs.compactMap { self.genres[Int64($0)]}.prefix(3).joined(separator: ", ")
    }
}
