import SwiftUI
import Foundation
import UTCTimeCore

@Observable
class TimeZoneViewModel {
    public var utcInput: String = ""
    public var parsedDate: Date?
    public var errorMessage: String = ""
    public var isValidInput: Bool = false
    
    public let predefinedTimeZones: [TimeZoneInfo] = TimeConversionService.predefinedTimeZones
    
    private let service = TimeConversionService()
    
    init() {
        utcInput = service.defaultUTCString(referenceDate: Date())
        parseUTCInput(utcInput)

        if let savedInput = UserDefaults.standard.string(forKey: "lastUTCInput"), !savedInput.isEmpty {
            utcInput = savedInput
            parseUTCInput(savedInput)
        }
    }
    
    func parseUTCInput(_ input: String) {
        let result = service.parse(input)
        parsedDate = result.date
        isValidInput = result.isValid
        errorMessage = result.errorMessage ?? ""

        if result.isValid {
            saveInput(input)
        }
    }
    
    private func saveInput(_ input: String) {
        UserDefaults.standard.set(input, forKey: "lastUTCInput")
    }
    
    func getTimeInTimeZone(_ timeZoneInfo: TimeZoneInfo) -> String {
        service.formattedTime(for: parsedDate, in: timeZoneInfo.timeZone)
    }
    
    func getCurrentTimeZoneTime() -> String {
        service.formattedTime(for: parsedDate, in: TimeZone.current)
    }
    
    func getCurrentTimeZoneName() -> String {
        return TimeZone.current.identifier
    }
    
    func getCurrentTimeZoneOffset() -> String {
        service.offsetString(for: parsedDate, in: TimeZone.current)
    }
    
    func getTimeZoneOffset(_ timeZone: TimeZone) -> String {
        service.offsetString(for: parsedDate, in: timeZone)
    }
    
    func refreshWithCurrentTime() {
        let now = Date()
        utcInput = service.defaultUTCString(referenceDate: now)
        parseUTCInput(utcInput)
    }
}
