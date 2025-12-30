//
//  TimeInputModel.swift
//  UTCTimeLookeriOS
//
//  Created by Lei Levi on 2025/03/12.
//

import Foundation
import Observation
import UTCTimeCore

@Observable
final class TimeInputModel {
    var utcInput: String = "" {
        didSet { parseUTCInput(utcInput) }
    }
    var parsedDate: Date?
    var errorMessage: String = ""
    var isValidInput: Bool = false
    let predefinedTimeZones: [TimeZoneInfo] = TimeConversionService.predefinedTimeZones

    @ObservationIgnored private let service = TimeConversionService()

    init() {
        let nowUTC = service.defaultUTCString(referenceDate: Date())
        utcInput = nowUTC
        parseUTCInput(nowUTC)
    }

    func refreshWithCurrentTime() {
        utcInput = service.defaultUTCString(referenceDate: Date())
    }

    func getTimeInTimeZone(_ timeZoneInfo: TimeZoneInfo) -> String {
        service.formattedTime(for: parsedDate, in: timeZoneInfo.timeZone)
    }

    func getTimeZoneOffset(_ timeZone: TimeZone) -> String {
        service.offsetString(for: parsedDate, in: timeZone)
    }

    private func parseUTCInput(_ input: String) {
        let result = service.parse(input)
        parsedDate = result.date
        isValidInput = result.isValid
        errorMessage = result.errorMessage ?? ""
    }
}
