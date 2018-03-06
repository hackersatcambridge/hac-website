import XCTest
@testable import HaCWebsiteLibTests

XCTMain([
  testCase(WorkshopTests.allTests),
  testCase(DateUtilsTests.allTests),
  testCase(DatabaseUtilsTests.allTests),
  testCase(EventApiControllerTests.allTests),
  testCase(MarkdownTests.allTests),
])
