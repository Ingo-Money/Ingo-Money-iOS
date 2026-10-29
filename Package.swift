// swift-tools-version: 5.10
// Ingo Money iOS SDK — Swift Package Manager manifest.
//
// Add this package by URL and `import IngoSdk`. Ingo hosts its binary frameworks as checksum-verified
// GitHub Release assets; MiSnap is pulled from Mitek's public Swift package.

import PackageDescription

// Version and the matching GitHub Releases download base are set for each release.
let v = "7.4.1"
let base = "https://github.com/Ingo-Money/Ingo-Money-iOS/releases/download/7.4.1"

// FraudForce is a vendored third-party binary (TransUnion / iovation) with its own release lineage, so
// its asset is published under its OWN version (e.g. 5.9.0), not the SDK release version `v`. Kept as a
// separate token, filled from the producer's versions.json, so the two can never silently drift.
let fraudForceVersion = "5.9.0"

let package = Package(
    name: "IngoMoneySDK",
    platforms: [.iOS(.v15)],
    products: [
        // One product. All integration types use the same binaries — the flavor is a
        // runtime choice via `IngoConfiguration`, not a separate package.
        .library(name: "IngoMoneySDK",
                 targets: ["IngoSdk", "IngoSdkUx", "IngoCoreUx", "IngoSharedSdk", "FraudForce", "IngoMoneySDKMiSnap"]),
    ],
    dependencies: [
        // Mitek MiSnap (public Swift package). Verified against Mitek MiSnap-iOS 5.12.0: the `MiSnap`
        // product vends MiSnap / MiSnapCamera / MiSnapScience / MobileFlow / MiSnapBarcodeScanner /
        // MiSnapCore, and `MiSnapUX` vends MiSnapUX / MiSnapAssetManager — so these two products
        // transitively supply every MiSnap framework the SDK links. (MiSnapBarcodeScanner is weak-linked
        // by MiSnapScience: it rides the MiSnap product remotely and is intentionally not vendored in the
        // offline Package.local channel.)
        //
        // EXACT pin, not a range: the Ingo binaries below are PREBUILT xcframeworks compiled and tested
        // against this specific MiSnap version, and the offline (Package.local) channel ships this exact
        // MiSnap. A floating range (upToNextMajor) would let a remote consumer resolve a newer 5.x than the
        // binaries were built against — a channel-divergence / dyld-symbol risk (Mitek keeps the dylib
        // compatibility version at 1.0.0, so nothing gates it). Ingo's build fails if this version differs
        // from the MiSnap the binaries are built against; bump it in lockstep with a rebuild.
        .package(url: "https://github.com/Mitek-Systems/MiSnap-iOS.git", exact: "5.12.0"),
    ],
    targets: [
        // Ingo binary frameworks — checksum-verified GitHub Release assets, downloaded anonymously.
        .binaryTarget(name: "IngoSharedSdk", url: "\(base)/IngoSharedSdk-\(v).xcframework.zip", checksum: "11374324aedba821f439a8ef42aa7717ab1c8cdfaca5d6690df00ec0ff33c8ef"),
        .binaryTarget(name: "IngoCoreUx",    url: "\(base)/IngoCoreUx-\(v).xcframework.zip",    checksum: "1f3cadc5687203b8776354bfd2711472ef6d2e5f73472e64d09c7f5857b73ca5"),
        .binaryTarget(name: "IngoSdkUx",     url: "\(base)/IngoSdkUx-\(v).xcframework.zip",     checksum: "5c577315e4599b76ada1115a65e814bb69f54c74893cc6fadfeb1a1c57014308"),
        .binaryTarget(name: "IngoSdk",       url: "\(base)/IngoSdk-\(v).xcframework.zip",       checksum: "ac4174897314ceb4146daace6decf2d03ea7718dbb7886085e3cf8544f3eaf5a"),
        .binaryTarget(name: "FraudForce",    url: "\(base)/FraudForce-\(fraudForceVersion).xcframework.zip", checksum: "5e15b7165536948864aefacc50c2ddb850c2869a7a544f5cf645f4f45c1f9f4e"),

        // Links MiSnap alongside the Ingo binaries (a binary target can't declare dependencies of its
        // own). You never import this module directly — `import IngoSdk`.
        .target(
            name: "IngoMoneySDKMiSnap",
            dependencies: [
                .product(name: "MiSnap",   package: "MiSnap-iOS"),
                .product(name: "MiSnapUX", package: "MiSnap-iOS"),
            ],
            path: "Sources/IngoMoneySDKMiSnap"
        ),
    ]
)
