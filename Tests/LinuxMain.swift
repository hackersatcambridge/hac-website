import XCTest
@testable import HaCWebsiteLibTests

XCTMain([
  testCase(WorkshopTests.allTests),
  testCase(DateUtilsTests.allTests),
  testCase(DatabaseUtilsTests.allTests),
  testCase(WorkshopTests.allTests),
  testCase(MarkdownTests.allTests),
])
