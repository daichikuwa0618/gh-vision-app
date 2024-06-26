// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "GitHubAPI",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "GitHubAPI", targets: ["GitHubAPI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-format", from: "510.1.0"),
    .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "GitHubAPI",
      dependencies: [
        .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
        .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
      ],
      plugins: [.plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")]
    ),
  ]
)
