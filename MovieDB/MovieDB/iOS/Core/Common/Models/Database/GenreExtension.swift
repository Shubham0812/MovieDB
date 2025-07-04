//
//  Genre.swift
//  MovieDB
//
//  Created by Shubham on 03/07/25.
//

import CoreData

extension Genre {
    convenience init(context: NSManagedObjectContext, from genre: GenreNW ) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Genre", in: context) else {
            fatalError("Couldn’t find entity 'Genre' in context")
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.id = genre.id
        self.name = genre.name
    }
}
