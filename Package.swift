// swift-tools-version: 6.0
// This is a Skip (https://skip.tools) package.
import PackageDescription

let package = Package(
    name: "ffmultiplier-2025",
    defaultLocalization: "en",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(name: "FFMultiplier2025", type: .dynamic, targets: ["FFMultiplier2025"]),
        .library(name: "FFMultiplierCore", type: .dynamic, targets: ["FFMultiplierCore"]),
        .library(name: "FFMultiplierModel", type: .dynamic, targets: ["FFMultiplierModel"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.6.29"),
        .package(url: "https://source.skip.tools/skip-fuse-ui.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-model.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-fuse.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-firebase.git", "0.9.0"..<"2.0.0")
    ],
    targets: [
        .target(
            name: "FFMultiplier2025",
            dependencies: [
                "FFMultiplierModel",
                .product(name: "SkipFuseUI", package: "skip-fuse-ui"),
                .product(name: "SkipFirebaseCore", package: "skip-firebase"),
            ],
            resources: [
                .process("Resources"),
            ],
            plugins: [
                .plugin(name: "skipstone", package: "skip"),
            ],
        ),
        .target(
            name: "FFMultiplierModel",
            dependencies: [
                "FFMultiplierCore",
                .product(name: "SkipModel", package: "skip-model"),
                .product(name: "SkipFuse", package: "skip-fuse"),
                .product(name: "SkipFirebaseCore", package: "skip-firebase"),
                .product(name: "SkipFirebaseFirestore", package: "skip-firebase"),
            ],
            resources: [.process("Resources"),],
            plugins: [.plugin(name: "skipstone", package: "skip"),],
        ),
        .target(
            name: "FFMultiplierCore",
            dependencies: [],
            resources: [.process("Resources"),],
        ),
    ]
)
