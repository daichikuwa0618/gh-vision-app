// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GitHubAPI",
    products: [
        .library(name: "GitHubAPI", targets: ["GitHubAPI"]),
    ],
    dependencies: [
      .package(url: "https://github.com/apple/swift-format", from: "510.1.0"),
    ],
    targets: [
        .target(
            name: "GitHubAPI"
        ),
    ]
)
