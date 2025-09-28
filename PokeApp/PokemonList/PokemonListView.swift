//
//  ContentView.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 26/09/25.
//


import SwiftUI
import Network
import GraphQLGenCode

struct PokemonListView: View {
    @StateObject var presenter: PokemonListPresenter
    var interactor: PokemonListBusinessLogic

    init(presenter: PokemonListPresenter, interactor: PokemonListBusinessLogic) {
        _presenter = StateObject(wrappedValue: presenter)
        self.interactor = interactor
    }

    var body: some View {
        NavigationView {
            Group {
                if let vm = presenter.viewModel {
                    List(vm.displayPokemons, id: \.self) { pokemon in
                        pok
                        PokemonRow(viewModel: )
                    }
                } else if let error = presenter.errorViewModel {
                    Text("Error: \(error.message)")
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Pokémons")
            .task {
                await interactor.fetch(request: PokemonList.Fetch.Request())
            }
        }
    }

}

struct MyApp: App {
    // @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            let repository = RemotePokemonRepository() // o Fake for dev
            let presenter = PokemonListPresenter()
            let interactor = PokemonListInteractor(repository: repository, presenter: presenter)
            PokemonListView(presenter: presenter, interactor: interactor)
        }
    }
}

extension GetPokemonsQuery.Data: @unchecked Sendable {}

