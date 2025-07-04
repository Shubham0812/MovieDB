//
//  PreviewDataProvider.swift
//  MovieDB
//
//  Created by Shubham on 03/07/25.
//

import Foundation
import CoreData

class PreviewCoreDataProvider {
    static let shared = PreviewCoreDataProvider()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "Movie") // Replace this
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Loading preview store failed: \(error)")
            }
        }
        
                
        initialiseSampleData()
    }
    
    func getSampleMovie() -> Movie {
        let context = container.viewContext
        let entity = Movie(context: context)
        
        entity.id = 123
        entity.title = "Inception"
        entity.overview = "Inception is a 2010 science fiction action heist film written and directed by Christopher Nolan, who also produced it with Emma Thomas, his wife. The film stars Leonardo DiCaprio as a professional thief who steals information by infiltrating the subconscious of his targets. He is offered a chance to have his criminal history erased as payment for the implantation of another person's idea into a target's subconscious."
        
        entity.voteAverage = 8.5
        entity.totalVotes = 10000
        entity.releaseDate = "2010"
        entity.genreIDs = "18,28"
        entity.isFavorite = true
        entity.category = "popular"
        entity.posterPath = "/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg"        
        return entity
    }
    
    func initialiseSampleData() {
        let context = container.viewContext
        let entity = getSampleMovie()
   
        try? context.save()
    }
}
