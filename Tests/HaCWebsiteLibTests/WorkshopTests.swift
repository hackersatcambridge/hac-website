import XCTest
@testable import HaCWebsiteLib

class WorkshopTests: HaCWebsiteLibTestCase {
  func testParse() throws {
    let testMetadata = try getTestResourceString(from: "conquering_linux/metadata.yaml")
    let testDescription = try getTestResourceString(from: "conquering_linux/description.md")
    let testPrerequisites = try getTestResourceString(from: "conquering_linux/prerequisites.md")

    let workshop = try Workshop.parse(metadataYaml: testMetadata, descriptionMarkdown: testDescription, prerequisitesMarkdown: testPrerequisites)
    
    XCTAssertEqual(workshop.title, "Conquering Linux")
    XCTAssertEqual(workshop.authors, ["Robin McCorkell"])
    XCTAssertEqual(workshop.presenters, ["Robin McCorkell"])
    XCTAssertEqual(workshop.thanks, [
      Workshop.Thanks(to: "Tristram Newman", reason: "Video"),
      Workshop.Thanks(to: "University of Cambridge Computer Laboratory", reason: nil)
    ])
    XCTAssertEqual(workshop.recommendations, [
      Workshop.Recommendation(title: "Install Guide", url: URL(string: "https://wiki.archlinux.org/index.php/Installation_guide")!),
      Workshop.Recommendation(title: "Arch Wiki", url: URL(string: "https://wiki.archlinux.org/")!)
    ])
    // Not attempting to match full HTML generated because whitespace may vary between Markdown renderers
    XCTAssert(workshop.prerequisites.html.contains("<a href=\"https://www.virtualbox.org/wiki/Downloads\">VirtualBox</a>"))
    XCTAssert(workshop.description.html.contains("A workshop on installing and configuring Arch Linux."))
    XCTAssertEqual(workshop.links, [URL(string: "https://www.youtube.com/watch?v=AqZWwsM3jaY")!])
    XCTAssertEqual(workshop.tags, ["Linux"])
  }

  func checkThrows(metadataPath: String) {
    let testMalformedMetadata = try! getTestResourceString(from: metadataPath)
    let testDescription = try! getTestResourceString(from: "conquering_linux/description.md")
    let testPrerequisites = try! getTestResourceString(from: "conquering_linux/prerequisites.md")

    XCTAssertThrowsError(try Workshop.parse(
      metadataYaml: testMalformedMetadata,
      descriptionMarkdown: testDescription,
      prerequisitesMarkdown: testPrerequisites
    ))
  }

  func testInvalidURL() {
    checkThrows(metadataPath: "invalid_url.yaml")
  }

  func testMissingRecommendationName() {
    checkThrows(metadataPath: "missing_name.yaml")
  }

  func testMissingTags() {
    checkThrows(metadataPath: "missing_tags.yaml")
  }

  func testMissingTitle() {
    checkThrows(metadataPath: "missing_title.yaml")
  }

  func testMissingThanksTo() {
    checkThrows(metadataPath: "missing_to.yaml")
  }

  // Should catch

  // Missing title
  // Missing array
  // Non-string when string expected
  // Missing 'to' property
  // Missing 'name' on recommendation
  // Invalid urls (empty string or special chars)
  // Missing tags array


  static var allTests : [(String, (WorkshopTests) -> () throws -> Void)] {
    return [
      ("testParse", testParse),
      ("testMissingTags", testMissingTags),
      ("testMissingTitle", testMissingTitle),
      ("testMissingThanksTo", testMissingThanksTo),
    ]
  }
}
