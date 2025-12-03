import Foundation

public struct TimeZoneInfo: Hashable, Sendable {
    public let name: String
    public let flag: String
    public let timeZone: TimeZone
    public let identifier: String

    public init(name: String, flag: String, timeZone: TimeZone, identifier: String) {
        self.name = name
        self.flag = flag
        self.timeZone = timeZone
        self.identifier = identifier
    }
}

public struct ParseResult: Sendable {
    public let date: Date?
    public let isValid: Bool
    public let errorMessage: String?
}

public final class TimeConversionService {
    public static let predefinedTimeZones: [TimeZoneInfo] = [
        TimeZoneInfo(name: "China", flag: "🇨🇳", timeZone: TimeZone(identifier: "Asia/Shanghai")!, identifier: "Asia/Shanghai"),
        TimeZoneInfo(name: "Hong Kong", flag: "🇭🇰", timeZone: TimeZone(identifier: "Asia/Hong_Kong")!, identifier: "Asia/Hong_Kong"),
        TimeZoneInfo(name: "US East", flag: "🇺🇸", timeZone: TimeZone(identifier: "America/New_York")!, identifier: "America/New_York"),
        TimeZoneInfo(name: "US West", flag: "🇺🇸", timeZone: TimeZone(identifier: "America/Los_Angeles")!, identifier: "America/Los_Angeles"),
        TimeZoneInfo(name: "UK", flag: "🇬🇧", timeZone: TimeZone(identifier: "Europe/London")!, identifier: "Europe/London"),
        TimeZoneInfo(name: "Japan", flag: "🇯🇵", timeZone: TimeZone(identifier: "Asia/Tokyo")!, identifier: "Asia/Tokyo"),
    ]

    private let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    private let simplifiedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    private let millisecondsNoTZFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    private let extendedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSXXX"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    private let timezoneFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssXXX"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    private let displayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()

    public init() {}

    public func defaultUTCString(referenceDate: Date = Date()) -> String {
        iso8601Formatter.string(from: referenceDate)
    }

    public func parse(_ input: String) -> ParseResult {
        let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedInput.isEmpty else {
            return ParseResult(date: nil, isValid: false, errorMessage: "Please enter a UTC time")
        }

        if let timestamp = Double(trimmedInput) {
            let date = Date(timeIntervalSince1970: timestamp)
            return ParseResult(date: date, isValid: true, errorMessage: nil)
        }

        if let date = iso8601Formatter.date(from: trimmedInput) {
            return ParseResult(date: date, isValid: true, errorMessage: nil)
        }

        if let date = simplifiedFormatter.date(from: trimmedInput) {
            return ParseResult(date: date, isValid: true, errorMessage: nil)
        }

        if let date = millisecondsNoTZFormatter.date(from: trimmedInput) {
            return ParseResult(date: date, isValid: true, errorMessage: nil)
        }

        if let date = extendedFormatter.date(from: trimmedInput) {
            return ParseResult(date: date, isValid: true, errorMessage: nil)
        }

        if let date = timezoneFormatter.date(from: trimmedInput) {
            return ParseResult(date: date, isValid: true, errorMessage: nil)
        }

        let message = "Invalid format. Use: 2025-07-28T14:30:00Z, 2025-07-28 14:30:00, 2025-07-28 14:30:00.123, 2025-08-02 03:56:00+00, or Unix timestamp"
        return ParseResult(date: nil, isValid: false, errorMessage: message)
    }

    public func formattedTime(for date: Date?, in timeZone: TimeZone) -> String {
        guard let date else { return "--:--:--" }
        displayFormatter.timeZone = timeZone
        return displayFormatter.string(from: date)
    }

    public func offsetString(for date: Date?, in timeZone: TimeZone) -> String {
        guard let date else { return "+00:00" }
        let offset = timeZone.secondsFromGMT(for: date)
        let hours = offset / 3600
        let minutes = abs(offset % 3600) / 60

        if minutes == 0 {
            return String(format: "%+03d:00", hours)
        } else {
            return String(format: "%+03d:%02d", hours, minutes)
        }
    }
}
