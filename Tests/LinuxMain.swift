import XCTest
@testable import HaCWebsiteLibTests

XCTMain([
  testCase(WorkshopTests.allTests),
  testCase(DateUtilsTests.allTests),
  testCase(NewWorkshopTests.allTests),
  testCase(MarkdownTests.allTests),
])
