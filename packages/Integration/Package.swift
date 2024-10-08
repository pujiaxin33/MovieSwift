// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Integration",
    platforms: [
        .iOS("17.0")
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Integration",
            targets: ["Integration"]),
    ],
    dependencies: [
        .package(path: "../Networking"),
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.15.3"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Integration",
            dependencies: [
                "Networking",
                .product(name: "SQLite", package: "SQLite.swift"),
                "Kingfisher"
            ]
        ),
        .testTarget(
            name: "IntegrationTests",
            dependencies: ["Integration"]),
    ]
)
