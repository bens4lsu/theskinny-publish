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
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.8.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.5"),
        .package(url: "https://github.com/swiftcsv/SwiftCSV.git", from: "0.8.0")
    ],
    targets: [
        .executableTarget(
            name: "Theskinny",
            dependencies: ["Publish", "Yams", "SwiftCSV"]
        )
    ]
)
