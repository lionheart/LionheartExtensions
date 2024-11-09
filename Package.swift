// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "LionheartExtensions",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "LionheartExtensions",
            targets: ["LionheartExtensionsCore"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "LionheartExtensionsCore",
            path: "Pod/Classes",
            sources: ["Core", "*.swift"],
            swiftSettings: [
                .define("SWIFT_VERSION", to: "5")
            ]
        ),
        .testTarget(
            name: "LionheartExtensionsTests",
            dependencies: ["LionheartExtensionsCore"]
        ),
    ]
)
