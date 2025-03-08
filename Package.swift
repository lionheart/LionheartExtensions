// swift-tools-version:6.0
import PackageDescription

let package = Package(
  name: "LionheartExtensions",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "LionheartExtensions",
      targets: ["LionheartExtensions"]
    )
  ],
  targets: [
    .target(name: "LionheartExtensions"),
    .testTarget(name: "LionheartExtensionsTests", dependencies: [.byName(name: "LionheartExtensions")])
  ],
  swiftLanguageModes: [.v6]
)
