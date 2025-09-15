# Realse Note

## Version History

### Version 1.1 (Latest)
**Release Date**: September 2025

#### New Features
- **Clipboard Integration**: Added "Paste from clipboard" button to quickly input UTC time from clipboard
- **Enhanced Time Format Support**:
  - Added support for millisecond timestamps without timezone (e.g., `2025-09-12 07:46:13.319`)
  - Improved parsing for various UTC time formats
- **App Icon**: Added complete app icon asset set with all required sizes for macOS
- **UI Improvements**: Added ScrollView for better content display on smaller windows

#### Documentation
- Added comprehensive README with usage instructions
- Created TODO.md for tracking future improvements
- Added LICENSE file (MIT License)
- Added AGENTS.md for AI agent configuration

#### Technical Improvements
- Updated project structure for better organization
- Enhanced ViewModel with additional time format parsers
- Improved error handling and validation

---

### Version 1.0
**Release Date**: August 2025

#### Core Features
- **UTC Time Input**: Text field to input UTC time in ISO 8601 format
- **Time Zone Conversion**: Automatic conversion to local and predefined time zones
- **Predefined Time Zones**:
  - Los Angeles (PST/PDT)
  - New York (EST/EDT)
  - London (GMT/BST)
  - Dubai (GST)
  - Singapore (SGT)
  - Beijing (CST)
  - Sydney (AEDT/AEST)
- **Current Time Button**: Quick button to use current UTC time
- **Context Menu**: Right-click on time zones to copy time or time with timezone info
- **Real-time Validation**: Instant feedback on input format validity

#### Technical Stack
- **Platform**: macOS 15.5+
- **Framework**: SwiftUI
- **Language**: Swift 5.0
- **Architecture**: MVVM with ObservableObject

#### UI Components
- Clean, native macOS design
- Time zone rows with country flags
- Color-coded sections for easy navigation
- Responsive layout

---

## Upgrade Notes

### From 1.0 to 1.1
- No breaking changes
- All existing functionality preserved
- New clipboard feature enhances workflow efficiency
- Improved time format support handles more input variations