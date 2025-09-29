//
//  PokemonEvolutionView.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 29/09/25.
//

import SwiftUI

struct PokemonEvolutionView: View {
    let pokemon: PokemonDTO

    var body: some View {
        VStack {
            if pokemon.evolutions.isEmpty == false {
                PokemonGrid(pokemons: pokemon.evolutions) { pokemons in

                } didSelectPokemon: { _ in

                }

            } else {
                Text("\(pokemon.name) no tiene más evoluciones.")
            }
        }
    }
}
