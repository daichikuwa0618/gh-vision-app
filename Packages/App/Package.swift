// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension Target {
  static func feature(name: String, dependency: [Dependency] = []) -> Target {
    return .target(name: name, dependencies: dependency, path: "Sources/Features/\(name)")
  }
}

extension Target.Dependency {
  static var commonUI: Self { .target(name: "CommonUI") }
  static var composableArchitecture: Self { .product(name: "ComposableArchitecture", package: "swift-composable-architecture") }
  static var core: Self { .product(name: "Core", package: "Core") }
}

var targets: [Target] = [
  .target(name: "CommonUI"),
  .feature(
    name: "UserList",
    dependency: [
      .commonUI,
      .composableArchitecture,
      .core,
    ]
  ),
  .testTarget(name: "UserListTests", dependencies: ["UserList"])
]

let targetsExcludingTests = targets.filter { !$0.isTest }

targets.append(
  .target(
    name: "App",
    dependencies: targetsExcludingTests.map { .target(name: $0.name) }
  )
)

let package = Package(
  name: "App",
  defaultLocalization: "en",
  platforms: [.iOS(.v16)],
  products: [
    .library(name: "App", targets: ["App"]),
  ] + targetsExcludingTests
    .map(\.name)
    .map { .library(name: $0, targets: [$0]) },
  dependencies: [
    .package(name: "Core", path: "../Core"),
    .package(url: "https://github.com/apple/swift-format", from: "510.1.0"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.11.2"),
  ],
  targets: targets
)
