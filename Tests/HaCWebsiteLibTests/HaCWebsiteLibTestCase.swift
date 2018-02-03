import Foundation
import XCTest

class HaCWebsiteLibTestCase: XCTestCase {
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
  func getTestResourcePath(at relativePath: String, file: String = #file, line: UInt = #line) throws -> String {
    let thisFile = #file
    let components = thisFile.split(separator: "/").map(String.init)
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
  func getTestResourceString(from relativePath: String, file: String = #file, line: UInt = #line) throws -> String {
    let path = try getTestResourcePath(at: relativePath, file: file, line: line)
    do {
      return try String(contentsOfFile: path, encoding: .utf8)
    } catch {
      self.recordFailure(withDescription: "Could not load file at \(path)", inFile: file, atLine: line, expected: false)
      throw TestError.couldNotLoadFile("path")
    }
  }
}