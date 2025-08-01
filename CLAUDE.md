# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

UTCTimeLooker is a macOS SwiftUI application for time zone lookup and UTC time display. The project is a basic starter app with minimal functionality currently implemented.

## Project Structure

- `UTCTimeLooker/` - Main application source code
  - `UTCTimeLookerApp.swift` - Main app entry point using SwiftUI App protocol
  - `ContentView.swift` - Main view displaying basic "Hello, world!" content
  - `Assets.xcassets/` - Application assets (app icon, accent colors)
  - `UTCTimeLooker.entitlements` - App entitlements for macOS

## Build Commands

This is an Xcode project that can be built using:

```bash
# Build the project from command line
xcodebuild -project UTCTimeLooker.xcodeproj -scheme UTCTimeLooker -configuration Debug build

# Build for release
xcodebuild -project UTCTimeLooker.xcodeproj -scheme UTCTimeLooker -configuration Release build

# Open in Xcode (preferred development method)
open UTCTimeLooker.xcodeproj
```

## Development Environment

- **Platform**: macOS (minimum deployment target: macOS 15.5)
- **Language**: Swift 5.0
- **Framework**: SwiftUI
- **IDE**: Xcode 16.4+
- **Bundle ID**: levi.UTCTimeLooker

## Code Architecture

The app follows the standard SwiftUI app architecture:

- **UTCTimeLookerApp**: Main app struct conforming to the App protocol, defines the root WindowGroup
- **ContentView**: The primary view displayed in the window, currently contains placeholder content

The project uses a simple single-window architecture suitable for a utility app focused on time zone display and UTC time lookups.

## Development Notes

- The project uses automatic code signing with development team ID HZAP4JA28N
- SwiftUI previews are enabled for rapid UI development
- The app has hardened runtime enabled for macOS security requirements
- Currently in initial development stage with minimal functionality implemented