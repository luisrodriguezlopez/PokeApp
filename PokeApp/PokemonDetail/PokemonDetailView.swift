//
//  PokemonDetailView.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 29/09/25.
//
import SwiftUI
import CoreData
enum DetailTab: String, CaseIterable, Identifiable {
    case attacks = "Ataques"
    case evolutions = "Evoluciones"

    var id: String { self.rawValue }
}

struct PokemonDetailView: View {
    let pokemon: PokemonDTO
    var animation: Namespace.ID
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width

    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab: DetailTab = .attacks

    var body: some View {
        ScrollView {
            VStack {
                VStack{
                HStack {

                    ForEach(pokemon.types, id: \.self) { type in
                        Text(type)
                            .font(.subheadline)
                            .bold()
                            .padding(.all, 4)
                            .foregroundColor(.white)
                            .background(.gray.opacity(0.3))
                            .cornerRadius(8)
                    }

                    Spacer()
                    Text("# \(pokemon.number)")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all, 4)
                }
                .padding(.all, 32)

            }
                AsyncImage(url: pokemon.imageURL)  { image in
                    image.resizable()
                }
                placeholder: {
                    Color.gray
                }
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .padding(.top,32)



                VStack {
                    VStack {

                        Picker("Detalles", selection: $selectedTab) {
                            ForEach(DetailTab.allCases) { tab in
                                Text(tab.rawValue)
                                    .tag(tab)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        .frame(height: 40)
                        .frame(width: 200)

                        Group {
                            switch selectedTab {
                            case .attacks:
                                if let attacks = pokemon.attacks?.all {
                                    AttacksStatsView(attacks: attacks)
                                } else {
                                    Text("No known attacks.")
                                }
                            case .evolutions:
                                PokemonEvolutionView(pokemon: pokemon)
                            }
                        }
                        .padding()
                    }
                }
                .frame(width: screenWidth ,height: screenHeight / 1.9)
                .background(.white)
                .cornerRadius(20)
                .padding(.top, 16)
            }
        }
        .navigationBarBackButtonHidden(true)
           .toolbar {
               ToolbarItem(placement: .navigationBarLeading) {
                   Button(action: onDismiss) {
                       Image(systemName: "chevron.left")
                           .foregroundColor(.white)
                   }
               }
               ToolbarItem(placement: .topBarTrailing) {
                   Button(action: saveFavorite) {
                       if pokemon.typeColor() != .red {
                           Image(systemName: "heart.fill")
                               .foregroundColor(isFavorite() ? .red : .white)
                       }else {
                           Image(systemName: "heart.fill")
                               .foregroundColor(isFavorite() ? .orange : .white)
                       }

                   }
               }
           }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(pokemon.typeColor().ignoresSafeArea(.all))
        .navigationBarBackButtonHidden(true)
        .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(pokemon.name)
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()

                    }
                }
        .toolbarBackground(pokemon.typeColor(), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)

    }

    func onDismiss() {
        self.dismiss()
    }

    func saveFavorite() {
        CoreDataManager.shared.toggleFavorite(for: pokemon.number)
    }

    func isFavorite() -> Bool {
        CoreDataManager.shared.isFavorite(pokemonNumber: pokemon.number)
    }

}
