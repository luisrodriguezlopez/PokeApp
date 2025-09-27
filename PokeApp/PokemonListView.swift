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

    @ObservedObject private var viewModel = PokemonViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }.accentColor(.white)
        .task {
            await viewModel.loadPokemons()
        }
    }

}

struct MyApp: App {
   // @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            PokemonListView()
        }
    }
}

@MainActor
final class PokemonViewModel: ObservableObject {
    @Published private var pokemons: [GetPokemonsQuery.Data.Pokemon] = []


    func loadPokemons() async {
        do {
            let data = try await PokemonRepository.fetchPokemons()
            pokemons = data.pokemons?.compactMap { $0 } ?? []
            print(pokemons)
        } catch {
            print("❌ \(error)")
        }
    }
}

extension GetPokemonsQuery.Data: @unchecked Sendable {}

