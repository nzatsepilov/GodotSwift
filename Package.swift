// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "GodotSwift",
    products: [
        .executable(name: "Generator", targets: ["Generator"]),
        .library(name: "Library", type: .dynamic, targets: ["Library"])
    ],
    dependencies: [
        .package(name: "SwiftSyntax", url: "https://github.com/apple/swift-syntax.git", .branch("main")),
        .package(name: "swift-collections", url: "https://github.com/apple/swift-collections.git", from: "0.0.2"),
    ],
    targets: [
        .target(name: "Core"),
        .target(name: "CGodot"),
        .target(
            name: "Godot",
            dependencies: ["CGodot"]
        ),
        .target(
            name: "Library",
            dependencies: ["Godot"],
            linkerSettings: [
                .unsafeFlags([
                    "-Xlinker", "-undefined",
                    "-Xlinker", "dynamic_lookup"
                ])
            ]
        ),
        .target(
            name: "Generator",
            dependencies: [
                .product(name: "OrderedCollections", package: "swift-collections"),
                .product(name: "SwiftSyntaxBuilder", package: "SwiftSyntax"),
                "Core"
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
