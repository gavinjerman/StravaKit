// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "StravaKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "StravaKit",
            targets: ["StravaKit"]),
    ],
    targets: [
        .target(
            name: "StravaKit",
            path: "Sources/StravaKit",
            exclude: ["StravaKitDemo/"]),
        .testTarget(
            name: "StravaKitTests",
            dependencies: ["StravaKit"],
            path: "Tests/StravaKitTests")
    ]
)