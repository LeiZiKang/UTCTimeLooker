import XCTest
@testable import UTCTimeCore

final class UTCTimeCoreTests: XCTestCase {
    func testParsesISO8601() {
        let service = TimeConversionService()
        let result = service.parse("2025-07-28T14:30:00Z")
        XCTAssertTrue(result.isValid)
        XCTAssertNotNil(result.date)
    }

    func testRejectsInvalidInput() {
        let service = TimeConversionService()
        let result = service.parse("invalid-date")
        XCTAssertFalse(result.isValid)
        XCTAssertNil(result.date)
        XCTAssertNotNil(result.errorMessage)
    }
}
