import XCTest
@testable import HaCWebsiteLib

class DateUtilsTests: HaCWebsiteLibTestCase {
  func testSingleDigitDate() {
    let readableDate = Date.from(year: 2017, month: 3, day: 2, hour: 9, minute: 0)
    let timestampDate = Date(timeIntervalSince1970: 1488445200)

    XCTAssertEqual(readableDate, timestampDate)
  }

  func testDoubleDigitDate() {
    let readableDate = Date.from(year: 2017, month: 10, day: 25, hour: 19, minute: 00)
    let timestampDate = Date(timeIntervalSince1970: 1508954400)

    XCTAssertEqual(readableDate, timestampDate)
  }

  func testTwiceOccurringDate() {
    // This time occurs twice because the clocks go back
    // We should take the time that this represents in the original time zone
    let twiceOccuringDate = Date.from(year: 2017, month: 10, day: 29, hour: 01, minute: 30)
    let timestampDate = Date(timeIntervalSince1970: 1509240600)

    XCTAssertEqual(twiceOccuringDate, timestampDate)
  }

  static var allTests : [(String, (DateUtilsTests) -> () -> Void)] {
    return [
      ("testSingleDigitDate", testSingleDigitDate),
      ("testDoubleDigitDate", testDoubleDigitDate),
      ("testTwiceOccuringDate", testTwiceOccurringDate)
    ]
  }
}
