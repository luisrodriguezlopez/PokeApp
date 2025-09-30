//
//  PokemonGrid.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 29/09/25.
//

import SwiftUI

struct PokemonGrid: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let screenWidth = UIScreen.main.bounds.width
    let pokemons: [PokemonDTO]
    var loadNextPage: (PokemonDTO) -> Void
    var didSelectPokemon: (PokemonDTO) -> Void
    @Namespace private var pokemonTransition

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(pokemons, id: \.id) { pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon, animation: pokemonTransition)) {

                        PokemonRow(namespace: pokemonTransition, viewModel: PokemonRowViewModel(pokemon: pokemon))
                            .frame(width: screenWidth * 0.45, height: 100)
                            .onAppear {
                                loadNextPage(pokemon)
                            }
                    }
                }
            }
        }
    }
}
