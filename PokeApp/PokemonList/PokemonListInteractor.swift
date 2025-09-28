//
//  Untitled.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 28/09/25.
//

import Network

protocol PokemonListBusinessLogic {
    func fetch(request: PokemonList.Fetch.Request) async
}

final class PokemonListInteractor: PokemonListBusinessLogic {
    private let repository: AppPokemonRepository
    private weak var presenter: PokemonListPresentationLogic?

    init(repository: AppPokemonRepository, presenter: PokemonListPresentationLogic) {
        self.repository = repository
        self.presenter = presenter
    }

    func fetch(request: PokemonList.Fetch.Request) async {
        do {
            let pokemons = try await repository.fetchPokemons()
            let response = PokemonList.Fetch.Response(pokemons: pokemons)
            presenter?.presentPokemons(response: response)
        } catch {
            presenter?.presentError(message: "Unable to fetch pokemons")
        }
    }
}
