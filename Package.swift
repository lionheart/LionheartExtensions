// swift-tools-version:5.10
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
    ]
)
