// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UTCTimeCore",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .watchOS(.v26),
    ],
    products: [
        .library(
            name: "UTCTimeCore",
            targets: ["UTCTimeCore"]
        ),
    ],
    targets: [
        .target(
            name: "UTCTimeCore"
        ),
        .testTarget(
            name: "UTCTimeCoreTests",
            dependencies: ["UTCTimeCore"]
        ),
    ]
)
