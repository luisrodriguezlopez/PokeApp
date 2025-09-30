// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetPokemonByNameQuery: GraphQLQuery {
  public static let operationName: String = "GetPokemonByName"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetPokemonByName($name: String!) { pokemon(name: $name) { __typename ...PokemonDetails } }"#,
      fragments: [PokemonDetails.self]
    ))

  public var name: String

  public init(name: String) {
    self.name = name
  }

  public var __variables: Variables? { ["name": name] }

  public struct Data: GraphQLGenCode.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { GraphQLGenCode.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("pokemon", Pokemon?.self, arguments: ["name": .variable("name")]),
    ] }

    public var pokemon: Pokemon? { __data["pokemon"] }

    /// Pokemon
    ///
    /// Parent Type: `Pokemon`
    public struct Pokemon: GraphQLGenCode.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GraphQLGenCode.Objects.Pokemon }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(PokemonDetails.self),
      ] }

      /// The ID of an object
      public var id: GraphQLGenCode.ID { __data["id"] }
      /// The identifier of this Pokémon
      public var number: String? { __data["number"] }
      /// The name of this Pokémon
      public var name: String? { __data["name"] }
      public var image: String? { __data["image"] }
      /// The classification of this Pokémon
      public var classification: String? { __data["classification"] }
      /// The type(s) of this Pokémon
      public var types: [String?]? { __data["types"] }
      /// The evolutions of this Pokémon
      public var evolutions: [Evolution?]? { __data["evolutions"] }
      /// The attacks of this Pokémon
      public var attacks: Attacks? { __data["attacks"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var pokemonDetails: PokemonDetails { _toFragment() }
      }

      public typealias Evolution = PokemonDetails.Evolution

      public typealias Attacks = PokemonDetails.Attacks
    }
  }
}
