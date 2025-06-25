// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Flash",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .macCatalyst(.v15),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "Flash",
            targets: ["Flash"]
        ),
    ],
    targets: [
        .target(name: "Flash"),
        .testTarget(
            name: "FlashTests",
            dependencies: ["Flash"]
        ),
    ]
)
