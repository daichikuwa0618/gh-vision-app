// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Core",
  products: [
    .library(name: "Core", targets: ["Core"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-format", from: "510.1.0"),
  ],
  targets: [
    .target(name: "Core"),
  ]
)
