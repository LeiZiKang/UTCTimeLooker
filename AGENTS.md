# Repository Guidelines

## Project Structure & Module Organization
- App source lives in `UTCTimeLooker/` (e.g., `UTCTimeLookerApp.swift`, `ContentView.swift`, `TimeZoneViewModel.swift`).
- Assets are under `UTCTimeLooker/Assets.xcassets/`.
- Xcode project file: `UTCTimeLooker.xcodeproj/` (no external package manager).
- The current layout is flat; when adding files, group by intent: `UTCTimeLooker/Models/`, `Views/`, `Utils/` (as referenced in README). Name files by role, e.g., `TimeParser.swift`, `TimeZoneModel.swift`, `TimeInputView.swift`.

## Build, Test, and Development Commands
- Open in Xcode: `open UTCTimeLooker.xcodeproj`
- Debug build: `xcodebuild -project UTCTimeLooker.xcodeproj -scheme UTCTimeLooker -configuration Debug build`
- Release build: `xcodebuild -project UTCTimeLooker.xcodeproj -scheme UTCTimeLooker -configuration Release build`
- Run tests (when a test target exists): `xcodebuild test -project UTCTimeLooker.xcodeproj -scheme UTCTimeLooker -destination 'platform=macOS'`

## Coding Style & Naming Conventions
- Language: Swift 5, UI: SwiftUI, pattern: MVVM where appropriate.
- Indentation: 4 spaces; keep lines readable (~120 chars).
- Types `UpperCamelCase`; functions/vars `lowerCamelCase`.
- Views end with `View` (e.g., `TimeZoneCardView`); view models end with `ViewModel`.
- Prefer `struct` for value types; mark non‑subclassed classes `final`.
- Keep logic in view models/utils; keep views declarative and side‑effect free.

## Testing Guidelines
- Framework: XCTest. Create target `UTCTimeLookerTests` and place tests under `UTCTimeLookerTests/`.
- File naming: `*Tests.swift`; methods start with `test...`.
- Focus on parsing and timezone conversion edge cases (ISO8601, ms precision, Unix timestamps, DST transitions).
- Run locally with the `xcodebuild test` command above.

## Commit & Pull Request Guidelines
- Use Conventional Commits (observed in history): `feat:`, `fix:`, `docs:`/`doc:`, `refactor:`, optional scope `feat(parser):`.
- One logical change per commit; keep messages imperative and concise.
- PRs must include: clear description, linked issue (if any), screenshots/GIFs for UI changes, test plan (commands run), and notes on known limitations.

## Security & Configuration Tips
- Do not commit secrets, DerivedData, or user‑specific Xcode files.
- Keep entitlements minimal (`UTCTimeLooker/UTCTimeLooker.entitlements`); prefer automatic signing for local builds.
- Target macOS 15.5+; verify the app launches and conversions render correctly before submitting.

