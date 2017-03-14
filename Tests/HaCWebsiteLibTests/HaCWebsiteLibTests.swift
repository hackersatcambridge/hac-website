import XCTest
@testable import HaCWebsiteLib

class HaCWebsiteLibTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(societyName(), "Hackers at Cambridge")
    }


    static var allTests : [(String, (HaCWebsiteLibTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
