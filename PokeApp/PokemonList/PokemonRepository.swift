//
//  PokemonRepository.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 28/09/25.
//

import Network
import GraphQLGenCode
import CoreData

protocol AppPokemonRepository {
    func fetchPokemons(itemsPerPage: Int) async throws -> [PokemonDTO]
    func toggleFavorite(pokemonId: Int64)
    func fetchFavorites() -> [PokemonEntity]
    func fetchLocalPokemons() throws -> [PokemonDTO]
}

public final class RemotePokemonRepository: AppPokemonRepository {
    private let network: NetworkingManager
    private let context = CoreDataManager.shared.context

    public init(network: NetworkingManager = NetworkingManager()) {
        self.network = network
    }

    func fetchPokemons(itemsPerPage: Int) async throws -> [PokemonDTO] {
            let network = NetworkingManager()
        let gqlData: GetPokemonsWithPaginationQuery.Data = try await network.fetch(query: GetPokemonsWithPaginationQuery(first: itemsPerPage))
        let pokemons: [PokemonDTO] = PokemonMapper.map(gqlData)
        savePokemons(pokemons)
        let response = PokemonList.Fetch.Response(pokemons: pokemons) // Error!
        return response.pokemons
    }


       func savePokemons(_ pokemons: [PokemonDTO]) {
           for dto in pokemons {
               let fetch: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
               fetch.predicate = NSPredicate(format: "number == %d", dto.number)

               if let existing = try? context.fetch(fetch).first {
                   // Update existing
                   existing.name = dto.name
                   existing.number = dto.number
                   existing.imageUrl = dto.imageURL?.absoluteString
                   existing.types = dto.types.joined(separator: ",")
               } else {
                   // Insert new
                   let entity = PokemonEntity(context: context)
                   entity.id = dto.id 
                   entity.name = dto.name
                   entity.number = dto.number
                   entity.imageUrl = dto.imageURL?.absoluteString
                   entity.types = dto.types.joined(separator: ",")
                   entity.isFavorite = false
               }
           }
           CoreDataManager.shared.saveContext()
       }

       func toggleFavorite(pokemonId: Int64) {
           let fetch: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
           fetch.predicate = NSPredicate(format: "number == %d", pokemonId)
           if let entity = try? context.fetch(fetch).first {
               entity.isFavorite.toggle()
               CoreDataManager.shared.saveContext()
           }
       }

       func fetchFavorites() -> [PokemonEntity] {
           let fetch: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        fetch.predicate = NSPredicate(format: "isFavorite == %@", NSNumber(value: true))

           do {
                return try context.fetch(fetch)
            } catch {
                print("Error fetching favorites: \(error)")
                return []
            }
       }

    func fetchLocalPokemons() throws -> [PokemonDTO] {
            let request: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
            let entities = try context.fetch(request)

            return entities.map { entity in
                PokemonDTO(id: entity.id ?? "",
                        number: entity.number ?? "",
                        name: entity.name ?? "",
                        imageURL: URL(string:  entity.imageUrl ?? ""),
                        classification: "",
                        types: [],
                        evolutions: [],
                        attacks: Attacks(from: nil)) 
            }
        }
}
