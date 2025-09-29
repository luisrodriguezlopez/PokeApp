//
//  Untitled.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 28/09/25.
//

import Network
import CoreData
protocol PokemonListBusinessLogic {
    func fetch(request: PokemonList.Fetch.Request , itemsPerPage: Int) async
    func fetchFavorites()
}

final class PokemonListInteractor: PokemonListBusinessLogic {
    private let repository: AppPokemonRepository
    private weak var presenter: PokemonListPresentationLogic?
    private let context = CoreDataManager.shared.context

    init(repository: AppPokemonRepository, presenter: PokemonListPresentationLogic) {
        self.repository = repository
        self.presenter = presenter
    }

    func fetch(request: PokemonList.Fetch.Request, itemsPerPage: Int) async {
        do {
            let pokemons = try await repository.fetchPokemons(itemsPerPage:itemsPerPage)
            let response = PokemonList.Fetch.Response(pokemons: pokemons)
            presenter?.presentPokemons(response: response)
        } catch {
            // 👇 Si falla la red, cargamos offline
            do {
                let localPokemons = try repository.fetchLocalPokemons()
                if localPokemons.isEmpty {
                    presenter?.presentError(message: "No hay conexión y no existen datos locales")
                } else {
                    let response = PokemonList.Fetch.Response(pokemons: localPokemons)
                    presenter?.presentPokemons(response: response)
                }
            }catch {
                presenter?.presentError(message: "No se pudieron cargar los Pokémon locales")
            }
        }
    }

    func toggleFavorite(pokemonId: Int64) {
        repository.toggleFavorite(pokemonId: pokemonId)
    }

    func fetchFavorites() {
        let entities = repository.fetchFavorites()
        let dtos = entities.map { entity in
            PokemonDTO(
                id: entity.id ?? "",
                number: entity.number ?? "",
                name: entity.name ?? "",
                imageURL: URL(string: entity.imageUrl ?? ""),
                classification: entity.classification ?? "",
                types: entity.types?.components(separatedBy: ",") ?? [],
                evolutions: [],
                    attacks:  nil
                   )
               }
        let response = PokemonList.Fetch.Response(pokemons: dtos)
        self.presenter?.presentFavorites(response:  response)
    }

}
