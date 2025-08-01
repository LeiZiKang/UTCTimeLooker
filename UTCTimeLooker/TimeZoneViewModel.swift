import SwiftUI
import Foundation

struct TimeZoneInfo {
    let name: String
    let flag: String
    let timeZone: TimeZone
    let identifier: String
}

class TimeZoneViewModel: ObservableObject {
    @Published var utcInput: String = ""
    @Published var parsedDate: Date?
    @Published var errorMessage: String = ""
    @Published var isValidInput: Bool = false
    
    let predefinedTimeZones: [TimeZoneInfo] = [
        TimeZoneInfo(name: "China", flag: "🇨🇳", timeZone: TimeZone(identifier: "Asia/Shanghai")!, identifier: "Asia/Shanghai"),
        TimeZoneInfo(name: "Hong Kong", flag: "🇭🇰", timeZone: TimeZone(identifier: "Asia/Hong_Kong")!, identifier: "Asia/Hong_Kong"),
        TimeZoneInfo(name: "US East", flag: "🇺🇸", timeZone: TimeZone(identifier: "America/New_York")!, identifier: "America/New_York"),
        TimeZoneInfo(name: "US West", flag: "🇺🇸", timeZone: TimeZone(identifier: "America/Los_Angeles")!, identifier: "America/Los_Angeles"),
        TimeZoneInfo(name: "UK", flag: "🇬🇧", timeZone: TimeZone(identifier: "Europe/London")!, identifier: "Europe/London"),
        TimeZoneInfo(name: "Japan", flag: "🇯🇵", timeZone: TimeZone(identifier: "Asia/Tokyo")!, identifier: "Asia/Tokyo")
    ]
    
    private let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    private let simplifiedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    private let extendedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSXXX"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    private let timezoneFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssXXX"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    private let displayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    init() {
        // Set default UTC time to current time
        let now = Date()
        utcInput = iso8601Formatter.string(from: now)
        parseUTCInput(utcInput)
        
        // Load saved input from UserDefaults
        if let savedInput = UserDefaults.standard.string(forKey: "lastUTCInput"), !savedInput.isEmpty {
            utcInput = savedInput
            parseUTCInput(savedInput)
        }
    }
    
    func parseUTCInput(_ input: String) {
        errorMessage = ""
        isValidInput = false
        parsedDate = nil
        
        let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedInput.isEmpty else {
            errorMessage = "Please enter a UTC time"
            return
        }
        
        // Try parsing as Unix timestamp first
        if let timestamp = Double(trimmedInput) {
            parsedDate = Date(timeIntervalSince1970: timestamp)
            isValidInput = true
            saveInput(input)
            return
        }
        
        // Try parsing as ISO 8601 format
        if let date = iso8601Formatter.date(from: trimmedInput) {
            parsedDate = date
            isValidInput = true
            saveInput(input)
            return
        }
        
        // Try parsing as simplified format
        if let date = simplifiedFormatter.date(from: trimmedInput) {
            parsedDate = date
            isValidInput = true
            saveInput(input)
            return
        }
        
        // Try parsing as extended format with milliseconds and timezone
        if let date = extendedFormatter.date(from: trimmedInput) {
            parsedDate = date
            isValidInput = true
            saveInput(input)
            return
        }
        
        // Try parsing format with timezone but no milliseconds
        if let date = timezoneFormatter.date(from: trimmedInput) {
            parsedDate = date
            isValidInput = true
            saveInput(input)
            return
        }
        
        // If all parsing fails, show error
        errorMessage = "Invalid format. Use: 2025-07-28T14:30:00Z, 2025-07-28 14:30:00, 2025-08-02 03:56:00+00, or Unix timestamp"
    }
    
    private func saveInput(_ input: String) {
        UserDefaults.standard.set(input, forKey: "lastUTCInput")
    }
    
    func getTimeInTimeZone(_ timeZoneInfo: TimeZoneInfo) -> String {
        guard let date = parsedDate else { return "--:--:--" }
        
        displayFormatter.timeZone = timeZoneInfo.timeZone
        return displayFormatter.string(from: date)
    }
    
    func getCurrentTimeZoneTime() -> String {
        guard let date = parsedDate else { return "--:--:--" }
        
        displayFormatter.timeZone = TimeZone.current
        return displayFormatter.string(from: date)
    }
    
    func getCurrentTimeZoneName() -> String {
        return TimeZone.current.identifier
    }
    
    func getCurrentTimeZoneOffset() -> String {
        let offset = TimeZone.current.secondsFromGMT()
        let hours = offset / 3600
        let minutes = abs(offset % 3600) / 60
        
        if minutes == 0 {
            return String(format: "%+03d:00", hours)
        } else {
            return String(format: "%+03d:%02d", hours, minutes)
        }
    }
    
    func getTimeZoneOffset(_ timeZone: TimeZone) -> String {
        guard let date = parsedDate else { return "+00:00" }
        
        let offset = timeZone.secondsFromGMT(for: date)
        let hours = offset / 3600
        let minutes = abs(offset % 3600) / 60
        
        if minutes == 0 {
            return String(format: "%+03d:00", hours)
        } else {
            return String(format: "%+03d:%02d", hours, minutes)
        }
    }
    
    func refreshWithCurrentTime() {
        let now = Date()
        utcInput = iso8601Formatter.string(from: now)
        parseUTCInput(utcInput)
    }
}