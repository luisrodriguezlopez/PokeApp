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
        let expectation = self.expectation(description: "Wait for screen transition to complete")

        let presenter = PokemonListPresenter()
        let pokemons = [

            PokemonDTO.init(id: "0", number: "", name: "Bulbasaur", imageURL: URL.init(string: "https://img.pokemondb.net/artwork/bulbasaur.jpg"), classification: "", types: [], evolutions: [],
                         attacks: nil)

        ]
        let response = PokemonList.Fetch.Response(pokemons: pokemons)
        presenter.presentPokemons(response: response)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

            expectation.fulfill()
            XCTAssertEqual(presenter.viewModel?.displayPokemons.first?.name ?? "", "Bulbasaur")

        }
        wait(for: [expectation], timeout: 2.0)

    }

    func test_presentError_createsErrorViewModel() {
        let presenter = PokemonListPresenter()
        presenter.presentError(message: "Network failed")

        XCTAssertEqual(presenter.errorViewModel?.message, "Network failed")
    }


}
