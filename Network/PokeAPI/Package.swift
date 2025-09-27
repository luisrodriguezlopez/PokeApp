// swift-tools-version:5.9

import PackageDescription

let package = Package(
  name: "GraphQLGenCode",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_14),
    .tvOS(.v12),
    .watchOS(.v5),
  ],
  products: [
    .library(name: "GraphQLGenCode", targets: ["GraphQLGenCode"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios", exact: "1.23.0"),
  ],
  targets: [
    .target(
      name: "GraphQLGenCode",
      dependencies: [
        .product(name: "ApolloAPI", package: "apollo-ios"),
      ],
      path: "./Sources"
    ),
  ]
)
