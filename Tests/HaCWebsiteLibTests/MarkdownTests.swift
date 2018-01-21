import XCTest
@testable import HaCWebsiteLib

class MarkdownTests: HaCWebsiteLibTestCase {
  func testAbsoluteOnly() throws {
    var markdown = Markdown(try getTestResourceString(from: "MarkdownRelativeURLTestData/absolute_only.md"))
    markdown.resolveRelativeURLs(relativeTo: URL(string: "https://test.com")!)

    XCTAssertEqual(markdown.raw,
      """
      This is a test

      Here's a link to somewhere else [Clickme](https://hackersatcambridge.com)

      ![Flower Pot Men](https://upload.wikimedia.org/wikipedia/en/c/c6/%22Flower_Pot_Men%22.jpg)

      Hello hello
      """
    )
  }

  func testSomeRelative() throws {
    var markdown = Markdown(try getTestResourceString(from: "MarkdownRelativeURLTestData/some_relative.md"))
    markdown.resolveRelativeURLs(relativeTo: URL(string: "https://test.com/stuff/test.html")!)

    XCTAssertEqual(markdown.raw,
      """
      This is a test

      Here's a link to somewhere else [Clickme](https://hackersatcambridge.com)

      ![Flower Pot Men](https://test.com/stuff/assets/billben.jpg)

      Hello hello
      """
    )
  }

  func testBracketing() throws {
    var markdown = Markdown(try getTestResourceString(from: "MarkdownRelativeURLTestData/brackets.md"))
    markdown.resolveRelativeURLs(relativeTo: URL(string: "https://test.com")!)

    XCTAssertEqual(markdown.raw,
      """
      This is a test

      Here's a link to somewhere else [Clickme](https://hackersatcambridge.com))

      [![Flower Pot Men](https://test.com/assets/billben.jpg)]]

      Hello hello
      """
    )
  }

  static var allTests : [(String, (MarkdownTests) -> () throws -> Void)] {
    return [
      ("testAbsoluteOnly", testAbsoluteOnly),
      ("testSomeRelative", testSomeRelative),
      ("testBracketing", testBracketing)
    ]
  }
}
