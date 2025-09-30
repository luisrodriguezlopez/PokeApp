//
//  CoreDataManager.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 29/09/25.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "PokemonApp") // nombre del .xcdatamodeld
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving Core Data: \(error)")
            }
        }
    }


    func toggleFavorite(for pokemonId: String) {
        let request: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        request.predicate = NSPredicate(format: "number == %@", pokemonId)

        if let result = try? context.fetch(request).first {
            result.isFavorite.toggle()
            try? context.save()
        }
    }


    func isFavorite(pokemonNumber: String) -> Bool {
        let request: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        request.predicate = NSPredicate(format: "number == %@", pokemonNumber)

        do {
            if let entity = try context.fetch(request).first {
                return entity.isFavorite
            } else {
                return false
            }
        } catch {
            print("Error checking favorite: \(error)")
            return false
        }
    }

    
}
