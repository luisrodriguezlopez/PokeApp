//
//  PokemonRowTests.swift
//  PokeAppTests
//
//  Created by Luis Rodríguez López on 28/09/25.
//

import XCTest
import SwiftUI

@testable import PokeApp
final class PokemonRowTests: XCTestCase {
    @Namespace private var pokemonTransition

    func test_pokemonRow_displaysCorrectNameAndNumber() {
          // Given
        let viewModel = PokemonRowViewModel(pokemon: PokemonDTO.init(id: "", number: "001", name: "Bulbasaur", imageURL: URL(string: ""), classification: "", types: [], evolutions: [], attacks: nil))

        let sut = PokemonRow( namespace: pokemonTransition , viewModel: viewModel)

        // Act
              let hostingController = UIHostingController(rootView: sut)

              // Assert: no debería crashear al cargar
              XCTAssertNotNil(hostingController.view)
        XCTAssertEqual(hostingController.rootView.viewModel.pokemon.name, "Bulbasaur")
        XCTAssertEqual(hostingController.rootView.viewModel.pokemon.number, "001")
    }
    


}
