// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "BlackmanClient",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "BlackmanClient",
            targets: ["BlackmanClient"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.0")
    ],
    targets: [
        .target(
            name: "BlackmanClient",
            dependencies: ["Alamofire"],
            path: "BlackmanClient/Classes"
        )
    ]
)
