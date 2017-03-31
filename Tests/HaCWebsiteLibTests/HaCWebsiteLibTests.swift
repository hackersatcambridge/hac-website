import XCTest
@testable import HaCWebsiteLib

class HaCWebsiteLibTests: XCTestCase {
  enum TestError: Error {
    case fileNotFound(String), couldNotLoadFile(String)
  }

  /**
   * Gets the absolute path to a resource in HaCWebsiteLibTests/Resources directory.
   * Generates an XCTest failure and throws an error if the resource cannot be found
   *
   * - returns:
   * A String of the absolute path to the resource
   *
   * - throws:
   * An error of type TestError.fileNotFound if the file cannot be found
   *
   * - parameters:
   *   - at: The path of the desired resource relative to HaCWebsiteLibTests/Resources
   *   - file: Optional file name for better error reporting
   *   - line: Optional line number for better error reporting
   */
  private func getTestResourcePath(at relativePath: String, file: String = #file, line: UInt = #line) throws -> String {
    let thisFile = #file
    let components = thisFile.characters.split(separator: "/").map(String.init)
    let toTestsDir = components[0 ..< components.count - 1]
    let filePath = "/" + toTestsDir.joined(separator: "/") + "/Resources/" + relativePath

    let fileManager = FileManager.default

    if fileManager.fileExists(atPath: filePath) {
      return filePath
    } else {
      self.recordFailure(withDescription: "Could not find file at \(filePath)", inFile: file, atLine: line, expected: false)
      throw TestError.fileNotFound(filePath)
    }
  }

  /**
   * Gets the String contents of a UTF8 encoded resource in HaCWebsiteLibTests/Resources directory.
   * Generates an XCTest failure and throws an error if the resource cannot be loaded
   *
   * - returns:
   * A String of the resource contents
   *
   * - throws:
   * An error of type TestError.couldNotLoadFile if the file cannot be loaded
   *
   * - parameters:
   *   - from: The path of the desired resource relative to HaCWebsiteLibTests/Resources
   *   - file: Optional file name for better error reporting
   *   - line: Optional line number for better error reporting
   */
  private func getTestResourceString(from relativePath: String, file: String = #file, line: UInt = #line) throws -> String {
    let path = try getTestResourcePath(at: relativePath, file: file, line: line)
    do {
      return try String(contentsOfFile: path, encoding: .utf8)
    } catch {
      self.recordFailure(withDescription: "Could not load file at \(path)", inFile: file, atLine: line, expected: false)
      throw TestError.couldNotLoadFile("path")
    }
  }

  func testWorkshopParse() throws {
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
    XCTAssert(workshop.prerequisites.contains("<a href=\"https://www.virtualbox.org/wiki/Downloads\">VirtualBox</a>"))
    XCTAssert(workshop.description.contains("A workshop on installing and configuring Arch Linux."))
    XCTAssertEqual(workshop.links, [URL(string: "https://www.youtube.com/watch?v=AqZWwsM3jaY")!])
    XCTAssertEqual(workshop.tags, ["Linux"])
  }

  static var allTests : [(String, (HaCWebsiteLibTests) -> () throws -> Void)] {
    return [
      ("testWorkshopParse", testWorkshopParse),
    ]
  }
}
