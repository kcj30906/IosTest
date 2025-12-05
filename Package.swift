// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "IosTest",
    platforms: [
        .iOS(.v13),
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "IosTest",
            targets: ["IosTest"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.10.1")
    ],
    targets: [
        .executableTarget(
            name: "IosTest",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire")
            ])
    ]
)
