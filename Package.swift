// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BudouX.swift",
    defaultLocalization: "en",
    products: [
        .library(
            name: "BudouX",
            targets: ["BudouX"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", exact: "1.2.2"),
        .package(url: "https://github.com/mxcl/Path.swift.git", exact: "1.4.0"),
    ],
    targets: [
        .target(
            name: "BudouX",
            dependencies: []),
        .executableTarget(
            name: "budoux-swift",
            dependencies: [
                "BudouX",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Path", package: "Path.swift"),
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
    ]
)
