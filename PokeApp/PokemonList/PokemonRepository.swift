//
//  PokemonRepository.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 28/09/25.
//

import Network
import GraphQLGenCode
protocol AppPokemonRepository {
    func fetchPokemons() async throws -> [PokemonDTO]
}

public final class RemotePokemonRepository: AppPokemonRepository {
    private let network: NetworkingManager

    public init(network: NetworkingManager = NetworkingManager()) {
        self.network = network
    }

    func fetchPokemons() async throws -> [PokemonDTO] {
            let network = NetworkingManager()
        let gqlData: GetPokemonsQuery.Data = try await network.fetch(query: GetPokemonsQuery())
        let pokemons: [PokemonDTO] = PokemonMapper.map(gqlData)
        let response = PokemonList.Fetch.Response(pokemons: pokemons) // Error!
        return response.pokemons
    }
}
