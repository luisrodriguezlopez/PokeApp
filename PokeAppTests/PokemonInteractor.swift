//
//  PokemonInteractor.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 28/09/25.
//
import Foundation
@testable import PokeApp
import XCTest





@MainActor
final class PokemonInteractorTests: XCTestCase {

    func test_loadPokemons_requestsRepository_and_presentsResponse() async {
        let mockRepo = MockRepository()
        mockRepo.result = .success([
            PokemonDTO.init(id: "", number: "", name: "Bulbasaur", imageURL: URL.init(string: "https://img.pokemondb.net/artwork/bulbasaur.jpg"), classification: "", types: [], evolutions: [],
                            attacks: nil)
        ])
        let spyPresenter = SpyPresenter()
        let interactor = PokemonListInteractor(repository: mockRepo, presenter: spyPresenter)

        await interactor.fetch(request: PokemonList.Fetch.Request(), itemsPerPage: 1)

        XCTAssertTrue(mockRepo.fetchCalled)
        XCTAssertEqual(spyPresenter.presentedResponse?.pokemons.first?.name, "Bulbasaur")
    }

    func test_loadPokemons_whenRepositoryFails_presentsError() async {
        let mockRepo = MockRepository()
        mockRepo.result = .failure(NSError(domain: "test", code: 1))
        let spyPresenter = SpyPresenter()
        let interactor = PokemonListInteractor(repository: mockRepo, presenter: spyPresenter)

        await interactor.fetch(request: PokemonList.Fetch.Request(), itemsPerPage: 1)

        XCTAssertEqual(spyPresenter.presentedErrorMessage, "No hay conexión y no existen datos locales")
    }
}



final class MockRepository: AppPokemonRepository {

     var toggleFavorite_wasCalled = false
     var fetchFavorites_wasCalled = false
     var fetchLocalPokemons_wasCalled = false

     var mockFavorites: [PokeApp.PokemonEntity] = []

     var mockLocalPokemons: [PokeApp.PokemonDTO] = []

     var shouldThrowError = false

     enum MockError: Error {
         case fetchFailed
     }

    
    var fetchCalled = false
    var result: Result<[PokemonDTO], Error> = .success([])

     func fetchPokemons(itemsPerPage: Int) async throws -> [PokemonDTO] {
        fetchCalled = true
        switch result {
        case .success(let pokemons): return pokemons
        case .failure(let error): throw error
        }
    }

    func toggleFavorite(pokemonId: Int64) {
        toggleFavorite_wasCalled = true

    }

    func fetchFavorites() -> [PokeApp.PokemonEntity] {
        fetchFavorites_wasCalled = true
             // 2. Devuelve los datos simulados
             return mockFavorites
    }

    func fetchLocalPokemons() throws -> [PokeApp.PokemonDTO] {
        fetchLocalPokemons_wasCalled = true

              // 2. Comprueba si debe lanzar un error simulado
              if shouldThrowError {
                  throw MockError.fetchFailed
              }

              // 3. Devuelve los datos simulados
              return mockLocalPokemons
    }

}

final class SpyPresenter: PokemonListPresentationLogic {
    func presentFavorites(response: PokeApp.PokemonList.Fetch.Response) {

    }
    
    var presentedResponse: PokemonList.Fetch.Response?
    var presentedErrorMessage: String?

    func presentPokemons(response: PokemonList.Fetch.Response) {
        presentedResponse = response
    }

    func presentError(message: String) {
        presentedErrorMessage = message
    }
}
