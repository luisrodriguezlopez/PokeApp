//
//  PokemonRow.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 28/09/25.
//
import SwiftUI

struct PokemonRow: View {
    var namespace: Namespace.ID // El namespace del padre
    let viewModel: PokemonRowViewModel
    @State private var showHeart = false

    var body: some View {
        VStack {
            HStack {

                VStack(alignment: .leading) {
                    Text(viewModel.pokemon.name)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    ForEach(viewModel.pokemon.types, id: \.count) { type in
                        VStack {
                            Text(type)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal,4)
                        .background(.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))

                    }


                    Text(viewModel.pokemon.number)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                //   .padding(.all,8)

                VStack {
                    Spacer()
                    AsyncImage(url: viewModel.pokemon.imageURL) { image in
                        image.resizable()

                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(.bottom, 4)

                }

            }
            .background(viewModel.pokemon.typeColor())
            .overlay(
                Image(systemName: "heart.fill")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 60, height: 60)
                    .scaleEffect(showHeart ? 1 : 0)
                    .opacity(showHeart ? 1 : 0)
            )
            .onLongPressGesture {
                CoreDataManager.shared.toggleFavorite(for: viewModel.pokemon.number)
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                    showHeart = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        showHeart = false
                    }
                }
            }

        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(viewModel.pokemon.typeColor())
        .clipShape(RoundedRectangle(cornerRadius: 8.0))

    }
}
