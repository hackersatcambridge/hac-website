import XCTest
@testable import HaCWebsiteLib

class NewWorkshopTests: HaCWebsiteLibTestCase {
  func testParse() throws {
    let workshopDataPath = try getTestResourcePath(at: "NewWorkshopTestData/workshop-passing-example")
    let workshop = try NewWorkshop(localPath: workshopDataPath)

    XCTAssertEqual(workshop.workshopId, "passing-example")
    XCTAssertEqual(workshop.title, "Sample Workshop")
    XCTAssertEqual(workshop.contributors, ["Richard HaC"])
    XCTAssertEqual(workshop.thanks, ["Hacky Hal the chatbot pal"])
    XCTAssertEqual(workshop.furtherReadingLinks, [
      Link(text: "Sampling", url: URL(string: "https://en.wikipedia.org/wiki/Sampling_(music)")!),
      Link(text: "Best websites a programmer should visit", url: URL(string: "https://github.com/sdmg15/Best-websites-a-programmer-should-visit#coding-practice-for-beginners")!)
    ])
    XCTAssertEqual(workshop.recordingLink, URL(string: "https://www.youtube.com/watch?v=FHG2oizTlpY"))
    XCTAssertEqual(workshop.slidesLink, URL(string: "https://docs.google.com/presentation/d/10VeyoN7EzxfezPjInAda_uEBZ1yp1UkY7z8ST78Do8Q"))
    XCTAssertEqual(workshop.tags, ["beginner", "javascript", "web", "programming"])
    XCTAssertEqual(workshop.license, "MIT")

    XCTAssert(workshop.notes.raw.contains("The main source of the workshop content."))

    // Note we currently do not test the promo image handling

    XCTAssertEqual(workshop.description.raw, "This workshop will take you through the basics of x. \nWe'll talk about how to foo and show you how, with a little work, you can bar your baz.")
    XCTAssertEqual(workshop.prerequisites.raw, "This workshop assumes:\n- Basic command line knowledge (you should be comfortable with the `cd`, `ls`, and `man` commands)\n- Some basic programming experience (you should be familiar with variables, loops and functions)")
    XCTAssertEqual(workshop.setupInstructions.raw, "If you have a Windows laptop, please install the application 'PuTTY' before you arrive by downloading ['putty.exe'](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html)\n\nThis workshop requires connection to a UNIX machine (Linux, macOS) so to play along you'll be connecting to a UNIX machine using PuTTY.")
    XCTAssertEqual(workshop.examplesLink?.absoluteString, "https://github.com/hackersatcambridge/workshop-passing-example/examples")
  }

  func testMissingDetails() {
    XCTAssertThrowsError(try NewWorkshop(localPath: try! getTestResourcePath(at: "NewWorkshopTestData/workshop-missing-contributors")))
    XCTAssertThrowsError(try NewWorkshop(localPath: try! getTestResourcePath(at: "NewWorkshopTestData/workshop-missing-notes")))
    XCTAssertThrowsError(try NewWorkshop(localPath: try! getTestResourcePath(at: "NewWorkshopTestData/workshop-missing-tags")))
  }

  func testDoubleBackground() {
    XCTAssertThrowsError(try NewWorkshop(localPath: try! getTestResourcePath(at: "NewWorkshopTestData/workshop-double-bg")))
  }

  static var allTests : [(String, (NewWorkshopTests) -> () throws -> Void)] {
    return [
      ("testParse", testParse),
      ("testMissingDetails", testMissingDetails),
      ("testDoubleBackground", testDoubleBackground)
    ]
  }
}
