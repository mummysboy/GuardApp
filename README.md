# GuardApp (SwiftUI, Multi-role)

A production-ready starter scaffold for an iOS SwiftUI app with **Admin**, **Business**, and **Worker** dashboards. 
This repo uses **XcodeGen** so you can generate a clean `.xcodeproj` on demand (no Pods).

## Quick Start

1. Install XcodeGen (if you don't have it):
   ```bash
   brew install xcodegen
   ```

2. Generate the Xcode project:
   ```bash
   xcodegen generate
   open GuardApp.xcodeproj
   ```

3. Run the app in the simulator (iOS 16+).

4. Wire up your backend base URL under `Configs/*.xcconfig` or the `Environment` struct in `APIClient.swift`.

## Structure

- `Sources/GuardApp/App` – App entry, session, routing
- `Sources/GuardApp/Views` – SwiftUI views per role (Admin/Business/Worker)
- `Sources/GuardApp/Services` – Protocol-based services (Auth, Networking)
- `Sources/GuardApp/Models` – DTOs and domain models
- `Sources/GuardApp/Components` – Shared SwiftUI components
- `Sources/GuardApp/Utils` – Helpers (Keychain, Idempotency, etc.)
- `Tests/GuardAppTests` – Unit tests

## Environments

XCConfigs are provided for `Debug`, `Staging`, and `Release`. Adjust bundle IDs and settings as needed.