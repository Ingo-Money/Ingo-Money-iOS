# Security Policy

## Reporting a vulnerability

If you believe you have found a security vulnerability in the Ingo Money iOS SDK, please report it privately
— **do not open a public issue.**

- Contact your Ingo Money representative and ask to be connected with the mobile security team. Include a
  description, the affected version, and reproduction steps.
- We aim to acknowledge reports within a reasonable timeframe and will coordinate a fix and disclosure.

Please do not include real credentials, customer data, tokens, or license keys in a report.

## Supported versions

Security fixes are provided for the current supported line only. `7.4.0` is the supported line; versions
before `7.4.0` are no longer supported. Upgrade to the latest release to receive fixes.

## Verifying what you resolved

This package is public, so verify you are running authentic, unmodified Ingo binaries. SwiftPM
checksum‑verifies each archive against the manifest on download; additionally, every Ingo framework is
code‑signed by **Ingo Money, Inc. (Team `9WZPUM527Q`)**:

```bash
codesign --verify --deep --strict \
  -R '=anchor apple generic and certificate leaf[subject.OU]="9WZPUM527Q"' \
  <path>/IngoSdk.xcframework
```

Only resolve this package from the canonical URL published by Ingo. A look‑alike or mirror that fails the
checksum or the signature check should be treated as untrusted.
