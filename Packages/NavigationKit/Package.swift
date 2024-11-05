// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NavigationKit",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "NavigationKit",
            targets: ["NavigationKit"]),
    ],
    targets: [
        .target(
            name: "NavigationKit"),
    ]
)
