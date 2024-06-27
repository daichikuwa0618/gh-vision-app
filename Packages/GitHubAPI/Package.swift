// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension Target.Dependency {
  static var core: Self { .product(name: "Core", package: "Core") }
  static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
}

let package = Package(
  name: "GitHubAPI",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "GitHubAPI", targets: ["GitHubAPI"]),
  ],
  dependencies: [
    .package(path: "../Core"),
    .package(url: "https://github.com/apple/swift-format", from: "510.1.0"),
    .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.3.1"),
  ],
  targets: [
    .target(
      name: "GitHubAPI",
      dependencies: [
        .core,
        .dependencies,
        .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
        .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
      ],
      plugins: [.plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")]
    ),
  ]
)
