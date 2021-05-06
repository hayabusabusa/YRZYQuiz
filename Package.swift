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
    ],
    dependencies: [
        
    ],
    targets: [
        .target(name: "Application", dependencies: [
            
        ]),
        .target(name: "Domain", dependencies: []),
        .target(name: "UIComponents", dependencies: []),
        .testTarget(name: "DomainTests", dependencies: ["Domain"]),
    ]
)
