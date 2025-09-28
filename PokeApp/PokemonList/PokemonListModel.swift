//
//  PokemonListModel.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 28/09/25.
//

enum PokemonList {
    enum Fetch {
        struct Request {}
        struct Response {
            let pokemons: [PokemonDTO]
        }
        struct ViewModel {
            let displayPokemons: [PokemonDTO]
        }
    }

    enum Error {
        struct ViewModel {
            let message: String
        }
    }
}
