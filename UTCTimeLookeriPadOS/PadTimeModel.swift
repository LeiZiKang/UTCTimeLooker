//
//  PadTimeModel.swift
//  UTCTimeLookeriPadOS
//
//  Created by Lei Levi on 2025/03/12.
//

import Foundation
import Observation
import UTCTimeCore

@Observable
final class PadTimeModel {
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

    var currentTimeZoneName: String {
        TimeZone.current.identifier
    }

    func currentTimeString() -> String {
        service.formattedTime(for: parsedDate, in: TimeZone.current)
    }

    func currentOffsetString() -> String {
        service.offsetString(for: parsedDate, in: TimeZone.current)
    }

    func refreshWithCurrentTime() {
        utcInput = service.defaultUTCString(referenceDate: Date())
    }

    func formattedTime(for timeZoneInfo: TimeZoneInfo) -> String {
        service.formattedTime(for: parsedDate, in: timeZoneInfo.timeZone)
    }

    func offsetString(for timeZoneInfo: TimeZoneInfo) -> String {
        service.offsetString(for: parsedDate, in: timeZoneInfo.timeZone)
    }

    private func parseUTCInput(_ input: String) {
        let result = service.parse(input)
        parsedDate = result.date
        isValidInput = result.isValid
        errorMessage = result.errorMessage ?? ""
    }
}
