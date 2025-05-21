// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Theskinny",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "Theskinny",
            targets: ["Theskinny"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/bens4lsu/Files", from: "0.9.4"),
        .package(url: "https://github.com/bens4lsu/Publish", from: "0.8.0"),
        .package(url: "https://github.com/jpsim/Yams", from: "5.0.5"),
        .package(url: "https://github.com/swiftcsv/SwiftCSV", from: "0.8.0"),
        .package(url: "https://github.com/ShawnMoore/XMLParsing", from: "0.0.3")
    ],
    targets: [
        .executableTarget(
            name: "Theskinny",
            dependencies: ["Files", "Publish", "Yams", "SwiftCSV", "XMLParsing"]
        )
    ]
)
