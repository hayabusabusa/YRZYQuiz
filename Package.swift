// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Application", targets: ["Application"]),
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "UIComponents", targets: ["UIComponents"]),
        .library(name: "Shared", targets: ["Shared"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(name: "Application", dependencies: [
            "Domain",
            "UIComponents",
            "Shared",
        ]),
        .target(name: "Domain", dependencies: [
            "Shared"
        ]),
        .target(name: "UIComponents", dependencies: []),
        .target(name: "Shared", dependencies: []),
        .testTarget(name: "ApplicationTests", dependencies: ["Application"]),
        .testTarget(name: "DomainTests", dependencies: ["Domain"]),
        .testTarget(name: "SharedTests", dependencies: ["Shared"]),
    ]
)
