// The Swift Programming Language
// https://docs.swift.org/swift-book

import ApolloAPI
import GraphQLGenCode
import Foundation
import Apollo


public class NetworkingManager {
    private let apolloClient: ApolloClient

    public init() {
        self.apolloClient = ApolloClient(url: URL(string: "https://graphql-pokemon2.vercel.app")!)

    }
    
    public func fetch<Query: GraphQLQuery>(query: Query) async throws -> Query.Data {
        try await withCheckedThrowingContinuation { continuation in
            apolloClient.fetch(query: query) { result in
                switch result {
                case .success(let graphQLResult):
                    if let data = graphQLResult.data {
                        continuation.resume(returning: data)
                    } else if let errors = graphQLResult.errors {
                        continuation.resume(throwing: errors.first ?? NSError(domain: "ApolloError", code: -1))
                    } else {
                        continuation.resume(throwing: NSError(domain: "ApolloError", code: -2))
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
