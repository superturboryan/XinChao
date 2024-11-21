// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XinChao",
    platforms: [.iOS(.v15), .macOS(.v14)],
    products: [
        .library(
            name: "XinChao",
            targets: ["XinChao"]),
    ],
    targets: [
        .target(
            name: "XinChao"),
    ]
)
