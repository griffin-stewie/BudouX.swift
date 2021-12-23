// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BudouX.swift",
    products: [
        .library(
            name: "BudouX",
            targets: ["BudouX"]),
        .library(
            name: "HTMLBudouX",
            targets: ["HTMLBudouX"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "1.0.2")),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "1.7.4"),
    ],
    targets: [
        .target(
            name: "BudouX",
            dependencies: []),
        .target(
            name: "HTMLBudouX",
            dependencies: [
                "BudouX",
                .product(name: "SwiftSoup", package: "SwiftSoup"),
            ]),
        .executableTarget(
            name: "budoux-swift",
            dependencies: [
                "BudouX",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .executableTarget(
            name: "generate-data",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Tools/generate-data"),
        .testTarget(
            name: "BudouXTests",
            dependencies: ["BudouX"]),
        .testTarget(
            name: "HTMLBudouXTests",
            dependencies: ["HTMLBudouX"]),
    ]
)
