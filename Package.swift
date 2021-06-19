// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "GodotSwift",
    products: [
        .executable(name: "Generator", targets: ["Generator"]),
        .library(name: "Godot", type: .dynamic, targets: ["Godot"])
    ],
    dependencies: [
        .package(name: "SwiftSyntax", url: "https://github.com/apple/swift-syntax.git", .branch("main")),
        .package(name: "swift-collections", url: "https://github.com/apple/swift-collections.git", from: "0.0.2"),
    ],
    targets: [
        .target(
            name: "Generator",
            dependencies: [
                .product(name: "OrderedCollections", package: "swift-collections"),
                .product(name: "SwiftSyntaxBuilder", package: "SwiftSyntax")
            ]
        ),
        .target(
            name: "CGodot"
        ),
        .target(
            name: "GodotTypes",
            dependencies: ["CGodot"]
        ),
        .target(
            name: "Godot",
            dependencies: ["GodotTypes"],
            linkerSettings: [
                .unsafeFlags([
                    // -Wl,-undefined,dynamic_lookup
                    // https://github.com/godotengine/godot-headers#compile-library
                    "-Xlinker", "-undefined",
                    "-Xlinker", "dynamic_lookup"
                ])
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
