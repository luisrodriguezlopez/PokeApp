//
//  PokemonListPresenter.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 28/09/25.
//

import Foundation


protocol PokemonListPresentationLogic: AnyObject {
    func presentPokemons(response: PokemonList.Fetch.Response)
    func presentError(message: String)
}

@MainActor
final class PokemonListPresenter: PokemonListPresentationLogic, ObservableObject {
    @Published var viewModel: PokemonList.Fetch.ViewModel?
    @Published var errorViewModel: PokemonList.Error.ViewModel?

    func presentPokemons(response: PokemonList.Fetch.Response) {
        let display = response.pokemons.map { "\($0.name)"}
        self.viewModel = PokemonList.Fetch.ViewModel(displayPokemons: display)
    }

    func presentError(message: String) {
        self.errorViewModel = PokemonList.Error.ViewModel(message: message)
    }
}
