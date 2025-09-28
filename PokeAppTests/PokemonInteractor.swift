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

        await interactor.fetch(request: PokemonList.Fetch.Request())

        XCTAssertTrue(mockRepo.fetchCalled)
        XCTAssertEqual(spyPresenter.presentedResponse?.pokemons.first?.name, "Bulbasaur")
    }

    func test_loadPokemons_whenRepositoryFails_presentsError() async {
        let mockRepo = MockRepository()
        mockRepo.result = .failure(NSError(domain: "test", code: 1))
        let spyPresenter = SpyPresenter()
        let interactor = PokemonListInteractor(repository: mockRepo, presenter: spyPresenter)

        await interactor.fetch(request: PokemonList.Fetch.Request())

        XCTAssertEqual(spyPresenter.presentedErrorMessage, "Unable to fetch pokemons")
    }
}



final class MockRepository: AppPokemonRepository {
    var fetchCalled = false
    var result: Result<[PokemonDTO], Error> = .success([])

     func fetchPokemons() async throws -> [PokemonDTO] {
        fetchCalled = true
        switch result {
        case .success(let pokemons): return pokemons
        case .failure(let error): throw error
        }
    }
}

final class SpyPresenter: PokemonListPresentationLogic {
    var presentedResponse: PokemonList.Fetch.Response?
    var presentedErrorMessage: String?

    func presentPokemons(response: PokemonList.Fetch.Response) {
        presentedResponse = response
    }

    func presentError(message: String) {
        presentedErrorMessage = message
    }
}
