// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProductCatalog",
    products: [
        .library(
            name: "ProductCatalog",
            targets: ["ProductCatalog"]),
    ],
    targets: [
        .target(
            name: "ProductCatalog"),
    ]
)
