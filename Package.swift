// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWScrollableMaskImageView",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "WWScrollableMaskImageView", targets: ["WWScrollableMaskImageView"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "WWScrollableMaskImageView", resources: [.process("Xib")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
