import XCTest
@testable import HaCWebsiteLib

class DateUtilsTests: HaCWebsiteLibTestCase {
  func testDate() {
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

  func testNeverOccurringDate() {
    // This time never occurs because the clocks go forwards over it
    // As such, this date should never have been used. We should crash
    // (implicitly unwrapped optional shold be nil)
    let neverOccuringDate = Date.from(year: 2017, month: 03, day: 26, hour: 01, minute: 30)
    XCTAssertNil(neverOccuringDate)
  }

  static var allTests : [(String, (DateUtilsTests) -> () -> Void)] {
    return [
      ("testDate", testDate),
      ("testTwiceOccuringDate", testTwiceOccurringDate),
      ("testNeverOccuringDate", testNeverOccurringDate)
    ]
  }
}
