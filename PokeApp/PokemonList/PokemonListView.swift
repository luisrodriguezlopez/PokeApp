//
//  ContentView.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 26/09/25.
//


import SwiftUI
import Network
import GraphQLGenCode

enum ListMode {
    case online
    case favorites
}
struct PokemonListView: View {
    let screenWidth  = UIScreen.main.bounds.width
    
    @StateObject var presenter: PokemonListPresenter
    var interactor: PokemonListBusinessLogic
    let columns = [GridItem(.adaptive(minimum:150)), GridItem(.adaptive(minimum:150))]
    @State var itemPerPage: Int = 15
    @Namespace private var pokemonTransition
    @State private var selectedPokemon: PokemonDTO?
    @State private var listMode: ListMode = .online
    
    
    init(presenter: PokemonListPresenter, interactor: PokemonListBusinessLogic) {
        _presenter = StateObject(wrappedValue: presenter)
        self.interactor = interactor
    }
    
    var body: some View {
        NavigationView {
            Group {
                ZStack {
                    
                    if let vm = presenter.viewModel {
                        PokemonGrid(pokemons: vm.displayPokemons) { pokemon in
                            self.loadNextPage(for: pokemon)
                        } didSelectPokemon: { pokemonSelected in
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                self.selectedPokemon = pokemonSelected
                            }
                        }
                        
                    } else if let error = presenter.errorViewModel {
                        Text("Error: \(error.message)")
                    } else {
                        ProgressView()
                    }
                    
                }
                .task {
                    if listMode == .online {
                        await interactor.fetch(request: PokemonList.Fetch.Request(),itemsPerPage: itemPerPage)
                    } else {
                        interactor.fetchFavorites()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Picker("Modo", selection: $listMode) {
                            Text("Todos").tag(ListMode.online)
                            Text("Favoritos").tag(ListMode.favorites)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 200)
                        .onChange(of: listMode) { newMode in
                            Task {
                                switch newMode {
                                case .online:
                                    await interactor.fetch(request: PokemonList.Fetch.Request(), itemsPerPage: itemPerPage)
                                case .favorites:
                                    interactor.fetchFavorites()
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Pokedex")
            }
        }
    }
    
    private func loadNextPage(for pokemon: PokemonDTO) {
        // Verifica si el Pokémon es el último de la lista para cargar más datos
        if presenter.isLast(pokemon) {
            itemPerPage += 15
            Task {
                await interactor.fetch(request: PokemonList.Fetch.Request(),itemsPerPage: itemPerPage)
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

extension GetPokemonsWithPaginationQuery.Data: @unchecked Sendable {}

