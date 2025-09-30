// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct PokemonDetails: GraphQLGenCode.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment PokemonDetails on Pokemon { __typename id number name image classification types evolutions { __typename id number name image } attacks { __typename fast { __typename name type damage } special { __typename name type damage } } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: any ApolloAPI.ParentType { GraphQLGenCode.Objects.Pokemon }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", GraphQLGenCode.ID.self),
    .field("number", String?.self),
    .field("name", String?.self),
    .field("image", String?.self),
    .field("classification", String?.self),
    .field("types", [String?]?.self),
    .field("evolutions", [Evolution?]?.self),
    .field("attacks", Attacks?.self),
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

  /// Evolution
  ///
  /// Parent Type: `Pokemon`
  public struct Evolution: GraphQLGenCode.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { GraphQLGenCode.Objects.Pokemon }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", GraphQLGenCode.ID.self),
      .field("number", String?.self),
      .field("name", String?.self),
      .field("image", String?.self),
    ] }

    /// The ID of an object
    public var id: GraphQLGenCode.ID { __data["id"] }
    /// The identifier of this Pokémon
    public var number: String? { __data["number"] }
    /// The name of this Pokémon
    public var name: String? { __data["name"] }
    public var image: String? { __data["image"] }
  }

  /// Attacks
  ///
  /// Parent Type: `PokemonAttack`
  public struct Attacks: GraphQLGenCode.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { GraphQLGenCode.Objects.PokemonAttack }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("fast", [Fast?]?.self),
      .field("special", [Special?]?.self),
    ] }

    /// The fast attacks of this Pokémon
    public var fast: [Fast?]? { __data["fast"] }
    /// The special attacks of this Pokémon
    public var special: [Special?]? { __data["special"] }

    /// Attacks.Fast
    ///
    /// Parent Type: `Attack`
    public struct Fast: GraphQLGenCode.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GraphQLGenCode.Objects.Attack }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("name", String?.self),
        .field("type", String?.self),
        .field("damage", Int?.self),
      ] }

      /// The name of this Pokémon attack
      public var name: String? { __data["name"] }
      /// The type of this Pokémon attack
      public var type: String? { __data["type"] }
      /// The damage of this Pokémon attack
      public var damage: Int? { __data["damage"] }
    }

    /// Attacks.Special
    ///
    /// Parent Type: `Attack`
    public struct Special: GraphQLGenCode.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GraphQLGenCode.Objects.Attack }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("name", String?.self),
        .field("type", String?.self),
        .field("damage", Int?.self),
      ] }

      /// The name of this Pokémon attack
      public var name: String? { __data["name"] }
      /// The type of this Pokémon attack
      public var type: String? { __data["type"] }
      /// The damage of this Pokémon attack
      public var damage: Int? { __data["damage"] }
    }
  }
}
