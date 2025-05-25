// swift-tools-version: 6.0
// This is a Skip (https://skip.tools) package.
import PackageDescription

let package = Package(
    name: "ffmultiplier-2025",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],
    products: [
        .library(name: "FFMultiplier2025", type: .dynamic, targets: ["FFMultiplier2025"]),
        .library(name: "FFMultiplierModel", type: .dynamic, targets: ["FFMultiplierModel"]),
        .library(name: "FFMultiplierCore", type: .dynamic, targets: ["FFMultiplierCore"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.5.18"),
        .package(url: "https://source.skip.tools/skip-fuse-ui.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-model.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-fuse.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "FFMultiplier2025", dependencies: [
            "FFMultiplierModel",
            .product(name: "SkipFuseUI", package: "skip-fuse-ui")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .target(name: "FFMultiplierModel", dependencies: [
            "FFMultiplierCore",
            .product(name: "SkipModel", package: "skip-model"),
            .product(name: "SkipFuse", package: "skip-fuse")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .target(name: "FFMultiplierCore", dependencies: []),
    ]
)
