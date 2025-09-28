//
//  Pokemon.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 28/09/25.
//

import Foundation
import GraphQLGenCode

struct PokemonDTO: Identifiable, Equatable {
    let id: String
    let number: String
    let name: String
    let imageURL: URL?
    let classification: String
    let types: [String]
    let evolutions: [PokemonDTO]
    let attacks: Attacks?
}

struct Evolution: Equatable {
    let id: Int
    let number: String
    let name: String
    let imageURL: URL?
}

struct Attacks: Equatable {
    var all: [Attack] = []

    init(from gqlAttacks: GetPokemonsQuery.Data.Pokemon.Attacks?) {
        guard let gqlAttacks = gqlAttacks else { return }

        // Fast attacks
        if let fast = gqlAttacks.fast?.compactMap({ $0 }) {
            all.append(contentsOf: fast.map {
                Attack(name: $0.name ?? "",
                       type: $0.type ?? "",
                       damage: $0.damage ?? 0,
                       category: .fast)
            })
        }

        // Special attacks
        if let special = gqlAttacks.special?.compactMap({ $0 }) {
            all.append(contentsOf: special.map {
                Attack(name: $0.name ?? "",
                       type: $0.type ?? "",
                       damage: $0.damage ?? 0,
                       category: .special)
            })
        }
    }

    var fast: [Attack] { all.filter { $0.category == .fast } }
    var special: [Attack] { all.filter { $0.category == .special } }
}

struct Attack: Equatable {
    let name: String
    let type: String
    let damage: Int
    let category: Category

    enum Category {
        case fast, special
    }
}

// MARK: - Mapper
struct PokemonMapper {
    static func map(_ data: GetPokemonsQuery.Data) -> [PokemonDTO] {
        guard let gqlPokemons = data.pokemons?.compactMap({ $0 }) else { return [] }
        return gqlPokemons.map { mapPokemon($0) }
    }

    private static func mapPokemon(_ gql: GetPokemonsQuery.Data.Pokemon) -> PokemonDTO {
        let evolutions: [PokemonDTO]? = gql.evolutions?.compactMap { $0 }.map { evo in
            PokemonDTO(id: evo.id,
                    number: evo.number ?? "",
                    name: evo.name ?? "",
                    imageURL: URL(string:  evo.image ?? ""),
                    classification: "",
                    types: [],
                    evolutions: [],
                    attacks: Attacks(from: nil)) // Evolutions can have empty attacks/types
        }

        return PokemonDTO(
            id: gql.id,
            number: gql.number ?? "",
            name: gql.name ?? "",
            imageURL: URL(string:  gql.image ?? ""),
            classification: gql.classification ?? "",
            types: gql.types?.compactMap { $0 } ?? [],
            evolutions: evolutions ?? [],
            attacks: Attacks(from: gql.attacks)
        )
    }
}
