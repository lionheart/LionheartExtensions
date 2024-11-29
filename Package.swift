// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "LionheartExtensions",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "LionheartExtensions",
            targets: ["LionheartExtensions"]
        ),
    ],
    targets: [
        .target(
            name: "LionheartExtensions"
        )
    ],
    swiftLanguageModes: [.v4]
)
