//
//  CoreDataService.swift
//  MovieDB
//
//  Created by Shubham on 03/07/25.
//

import CoreData

/// A lightweight, untyped CRUD service.
final class CoreDataService {
    private let context: NSManagedObjectContext

    /// Inject your existing NSPersistentContainer’s viewContext (or any context).
    init(context: NSManagedObjectContext) {
        self.context = context
    }

    /// Create a new object for the given entity name, configure it, and save.
    func create(entityName: String, configure: (NSManagedObject) -> Void) {
        guard let entityDesc = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            assertionFailure("Invalid entity name: \(entityName)")
            return
        }
        
        let obj = NSManagedObject(entity: entityDesc, insertInto: context)
        configure(obj)
        save()
    }

    /// Fetch all objects for the entity name, with optional predicate & sorting.
    func fetch(entityName: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [NSManagedObject] {
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.returnsObjectsAsFaults = false

        do {
            return try context.fetch(request)
        } catch {
            print("Fetch error for \(entityName):", error)
            return []
        }
    }
    
    func fetch<T: NSManagedObject>( _ type: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil ) -> [T] {
       // perform the untyped fetch
       let raw = fetch( entityName: T.entity().name ?? "", predicate: predicate, sortDescriptors: sortDescriptors )
       // cast for you
       return raw.compactMap { $0 as? T }
     }

    /// Delete the given managed object and save.
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        save()
    }

    /// Save any pending changes.
    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Save error:", error)
        }
    }
}
