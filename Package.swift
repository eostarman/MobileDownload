// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MobileDownload",
    platforms: [ .macOS(.v10_15), .iOS(.v13) ],
    products: [
        .library(
            name: "MobileDownload",
            targets: ["MobileDownload"]),
    ],
    dependencies: [
        .package(path: "../MoneyAndExchangeRates"),
        .package(path: "../MobileLegacyOrder")
    ],
    targets: [
        .target(
            name: "MobileDownload",
            dependencies: ["MoneyAndExchangeRates", "MobileLegacyOrder"]),
        .testTarget(
            name: "MobileDownloadTests",
            dependencies: ["MobileDownload", "MoneyAndExchangeRates", "MobileLegacyOrder"]),
    ]
)
