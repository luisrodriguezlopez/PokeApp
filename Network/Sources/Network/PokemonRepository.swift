//
//  PokemonRepository.swift
//  Network
//
//  Created by Luis Rodríguez López on 26/09/25.
//
import GraphQLGenCode
import Apollo
public protocol PokemonRepositoryProtocol {
    func fetchPokemons(itemsPerPage: Int) async throws ->  GetPokemonsWithPaginationQuery.Data
}
public final class RemotePokemonRepository: PokemonRepositoryProtocol {
    init() {}
    public func fetchPokemons(itemsPerPage: Int) async throws ->  GetPokemonsWithPaginationQuery.Data {
        let network = NetworkingManager()
        return try await network.fetch(query: GetPokemonsWithPaginationQuery(first: itemsPerPage))
    }
}
