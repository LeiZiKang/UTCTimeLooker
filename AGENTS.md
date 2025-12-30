# Repository Guidelines

## Project Structure & Module Organization
- `UTCTimeLookerMacOS/` is the macOS SwiftUI target (app entry point, views, view model, and entitlements).
- `UTCTimeLookeriOS/`, `UTCTimeLookeriPadOS/`, and `UTCTimeLookerWatchOS Watch App/` hold platform-specific SwiftUI targets.
- Platform UI state is handled with Observation models: `UTCTimeLookeriOS/TimeInputModel.swift`, `UTCTimeLookeriPadOS/PadTimeModel.swift`, and `UTCTimeLookerWatchOS Watch App/WatchTimeModel.swift`.
- `Packages/UTCTimeCore/` contains the shared Swift Package for parsing and time-zone logic; sources live in `Packages/UTCTimeCore/Sources/UTCTimeCore` and tests in `Packages/UTCTimeCore/Tests/UTCTimeCoreTests`.
- Each target has its own `Assets.xcassets` for images and app icons.

## Build, Test, and Development Commands
- `open UTCTimeLooker.xcworkspace` (preferred) or `open UTCTimeLooker.xcodeproj` to work in Xcode.
- `xcodebuild -project UTCTimeLooker.xcodeproj -scheme UTCTimeLooker -configuration Debug build` builds the macOS app in Debug.
- `xcodebuild -project UTCTimeLooker.xcodeproj -scheme UTCTimeLooker -configuration Release build` builds a Release binary.
- `xcodebuild -project UTCTimeLooker.xcodeproj -scheme UTCTimeLookerSIT -configuration Debug build` builds the SIT bundle for side-by-side installs.
- `xcodebuild -project UTCTimeLooker.xcodeproj -scheme UTCTimeLookeriOS -configuration Debug build` builds the iOS app target.
- `xcodebuild -project UTCTimeLooker.xcodeproj -scheme UTCTimeLookeriPadOS -configuration Debug build` builds the iPadOS app target.
- `xcodebuild -project UTCTimeLooker.xcodeproj -scheme "UTCTimeLookerWatchOS Watch App" -configuration Debug build` builds the watchOS app target.
- `swift test --package-path Packages/UTCTimeCore` runs shared package tests (or `xcodebuild test -project UTCTimeLooker.xcodeproj -scheme UTCTimeLooker` from Xcode tooling).

## Coding Style & Naming Conventions
- Follow standard Swift/SwiftUI conventions: 4-space indentation, one primary type per file, and small, composable views.
- Name types with PascalCase (`TimeZoneViewModel`) and functions/variables with camelCase (`parseInput`).
- Prefer shared logic in `UTCTimeCore` over duplicating it in platform targets.
- Use the Observation framework (`@Observable` models + `@Bindable` views) for UI state instead of `ObservableObject`.
- No repo-wide formatter or linter is configured; keep formatting consistent with existing files.

## Testing Guidelines
- Tests use Swift Testing (`import Testing`) in `Packages/UTCTimeCore/Tests/UTCTimeCoreTests`.
- Name suites `*Tests` and use `@Test` functions with clear, behavior-oriented names.
- No coverage threshold is enforced; add tests for parsing and time-zone conversion edge cases.

## Commit & Pull Request Guidelines
- Recent history follows Conventional Commits (e.g., `feat: add ...`, `fix(project): ...`). Use `type(scope): summary` when helpful.
- PRs should include a short summary, testing performed (commands and results), and screenshots for UI changes.
- Link related issues or feature requests when applicable.
