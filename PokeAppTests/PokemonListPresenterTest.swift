//
//  PokemonListPresenterTests.swift
//  PokeAppTests
//
//  Created by Luis Rodríguez López on 28/09/25.
//

import XCTest
@testable import PokeApp
@MainActor
final class PokemonListPresenterTests: XCTestCase {


    func test_presentPokemons_createsCorrectViewModel() {
        let presenter = PokemonListPresenter()
        let pokemons = [

            PokemonDTO.init(id: "0", number: "", name: "Bulbasaur", imageURL: URL.init(string: "https://img.pokemondb.net/artwork/bulbasaur.jpg"), classification: "", types: [], evolutions: [],
                         attacks: nil)

        ]
        let response = PokemonList.Fetch.Response(pokemons: pokemons)

        presenter.presentPokemons(response: response)

        XCTAssertEqual(presenter.viewModel?.displayPokemons.first, "Bulbasaur")
    }

    func test_presentError_createsErrorViewModel() {
        let presenter = PokemonListPresenter()
        presenter.presentError(message: "Network failed")

        XCTAssertEqual(presenter.errorViewModel?.message, "Network failed")
    }


}
