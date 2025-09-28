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

    func test_pokemonRow_displaysCorrectNameAndNumber() {
          // Given
          let viewModel = PokemonRowViewModel(
              id: "001",
              name: "Bulbasaur",
              number: "#001",
              imageURL: "https://img.pokemondb.net/artwork/bulbasaur.jpg"
          )

          let sut = PokemonRow(viewModel: viewModel)

        // Act
              let hostingController = UIHostingController(rootView: sut)

              // Assert: no debería crashear al cargar
              XCTAssertNotNil(hostingController.view)
              XCTAssertEqual(hostingController.rootView.viewModel.name, "Bulbasaur")
              XCTAssertEqual(hostingController.rootView.viewModel.number, "#001")
    }
    


}
