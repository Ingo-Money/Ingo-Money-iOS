# Ingo Money iOS SDK

[![Release](https://img.shields.io/github/v/release/Ingo-Money/Ingo-Money-iOS?sort=semver&label=release&color=2ea043)](https://github.com/Ingo-Money/Ingo-Money-iOS/releases/latest)
[![Swift](https://img.shields.io/badge/Swift-5%20%7C%206-F05138?logo=swift&logoColor=white)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-26.2%2B-147EFB?logo=xcode&logoColor=white)](https://developer.apple.com/xcode/)
[![Platform](https://img.shields.io/badge/platform-iOS%2015%2B-1575F9?logo=apple&logoColor=white)](https://developer.apple.com/ios/)
[![SPM](https://img.shields.io/badge/Swift_Package_Manager-compatible-2ea043?logo=swift&logoColor=white)](https://www.swift.org/package-manager/)
[![Documentation](https://img.shields.io/badge/docs-DocC-8A2BE2?logo=readthedocs&logoColor=white)](https://ingo-money.github.io/Ingo-Money-iOS/documentation/ingosdk)
[![Validate](https://github.com/Ingo-Money/Ingo-Money-iOS/actions/workflows/validate.yml/badge.svg)](https://github.com/Ingo-Money/Ingo-Money-iOS/actions/workflows/validate.yml)
[![License](https://img.shields.io/badge/license-Proprietary-lightgrey)](LICENSE)

The official Swift package for the Ingo Money iOS SDK — Ingo's mobile check-capture and funding experience.

## Requirements

| | |
| --- | --- |
| Platforms | iOS 15.0+ |
| Xcode | 26.2+ |
| Swift language mode | 5 or 6 |

## Installation

In Xcode, **File ▸ Add Package Dependencies…** and enter:

```
https://github.com/Ingo-Money/Ingo-Money-iOS
```

Or in `Package.swift`:

```swift
.package(url: "https://github.com/Ingo-Money/Ingo-Money-iOS.git", from: "7.4.1"),
```

Then add the **`IngoMoneySDK`** product to your app target.

## Usage

```swift
import IngoSdk

guard let baseURL = URL(string: "https://<your-ingo-base-url>") else {
    return  // handle an invalid base URL
}

let configuration = IngoConfiguration(
    baseURL: baseURL,
    customerID: "<customer-id>",
    authorizationToken: "<server-minted-token>",
    fraudForceBlackBox: "<fraudforce-black-box>",
    miSnapLicenseKey: ""  // Ingo provides the MiSnap license
)

let result = try await IngoSDK.run(configuration, from: self)
```

Add the camera and location usage descriptions to your app's `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Used to capture check images.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Used for fraud detection.</string>
```

## Documentation

Full API reference: <https://ingo-money.github.io/Ingo-Money-iOS/documentation/ingosdk>

## Support

For integration support, contact your Ingo Money representative. Security reports: see [SECURITY.md](SECURITY.md).

## License

Proprietary — see [LICENSE](LICENSE).
