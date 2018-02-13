import XCTest
@testable import HaCWebsiteLib

class DatabaseUtilsTests: HaCWebsiteLibTestCase {
  func testDatabaseComponentsExtraction() {
    XCTAssertEqual(
      URL(string: "postgres://richard:test@hac-db:5432/hac")!.databaseURLComponents,
      DatabaseURLComponents(
        host: "hac-db",
        user: "richard",
        password: "test",
        database: "hac"
      )
    )

    XCTAssertEqual(
      URL(string: "postgres://richard@hac-db:5432/hac")!.databaseURLComponents,
      nil
    )

    XCTAssertEqual(
      URL(string: "postgres://richard:test@hac-db:5432/")!.databaseURLComponents,
      DatabaseURLComponents(
        host: "hac-db",
        user: "richard",
        password: "test",
        database: ""
      )
    )

    XCTAssertNil(URL(string: "https://google.com/")!.databaseURLComponents)
  }

  static var allTests : [(String, (DatabaseUtilsTests) -> () -> Void)] {
    return [
      ("testDatabaseComponentsExtraction", testDatabaseComponentsExtraction)
    ]
  }
}
