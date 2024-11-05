// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProductCatalog",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "ProductCatalog",
            targets: ["ProductCatalog"]
        ),
    ],
    dependencies: [
        .package(
            name: "Networking",
            path: "../../Packages/Networking"
        ),
        .package(
            name: "Components",
            path: "../../Packages/Components"
        ),
        .package(
            name: "NavigationKit",
            path: "../../Packages/NavigationKit"
        ),
    ],
    targets: [
        .target(
            name: "ProductCatalog",
            dependencies: [
                "Networking",
                "Components",
                "NavigationKit",
            ]
        ),
    ]
)
