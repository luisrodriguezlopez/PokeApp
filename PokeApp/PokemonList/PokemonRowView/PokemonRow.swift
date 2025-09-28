//
//  PokemonRow.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 28/09/25.
//
import SwiftUI

struct PokemonRow: View {
    let viewModel: PokemonRowViewModel

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: viewModel.imageURL)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(viewModel.name)
                Text(viewModel.number)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
