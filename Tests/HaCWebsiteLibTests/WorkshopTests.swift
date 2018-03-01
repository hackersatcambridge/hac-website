import XCTest
@testable import HaCWebsiteLib

class WorkshopTests: HaCWebsiteLibTestCase {
  func testParse() throws {
    let workshopDataPath = try getTestResourcePath(at: "WorkshopTestData/workshop-passing-example")
    let workshop = try Workshop(localPath: workshopDataPath, headCommitSha: "abcde")

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

    XCTAssertEqual(workshop.promoImageForeground, "https://rawgit.com/hackersatcambridge/workshop-passing-example/abcde/.hac_workshop/promo_images/fg.png")
    XCTAssertEqual(workshop.promoImageBackground, Background.color("#fffeee"))

    XCTAssertEqual(workshop.description.raw, "This workshop will take you through the basics of x. \nWe'll talk about how to foo and show you how, with a little work, you can bar your baz.")
    XCTAssertEqual(workshop.prerequisites.raw, "This workshop assumes:\n- Basic command line knowledge (you should be comfortable with the `cd`, `ls`, and `man` commands)\n- Some basic programming experience (you should be familiar with variables, loops and functions)")
    XCTAssertEqual(workshop.setupInstructions.raw, "If you have a Windows laptop, please install the application 'PuTTY' before you arrive by downloading ['putty.exe'](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html)\n\nThis workshop requires connection to a UNIX machine (Linux, macOS) so to play along you'll be connecting to a UNIX machine using PuTTY.")
    XCTAssertEqual(workshop.examplesLink?.absoluteString, "https://github.com/hackersatcambridge/workshop-passing-example/tree/master/")
  }

  func testRelativeSlidesLink() throws {
    let workshopDataPath = try getTestResourcePath(at: "WorkshopTestData/workshop-relative-slides-link")
    let workshop = try Workshop(localPath: workshopDataPath, headCommitSha: "abcde")

    XCTAssertEqual(workshop.slidesLink, URL(string: "https://rawgit.com/hackersatcambridge/workshop-relative-slides-link/abcde/.hac_workshop/slides.html"))
  }

  func testMissingDetails() {
    XCTAssertThrowsError(try Workshop(localPath: try! getTestResourcePath(at: "WorkshopTestData/workshop-missing-contributors"), headCommitSha: "abcde"))
    XCTAssertThrowsError(try Workshop(localPath: try! getTestResourcePath(at: "WorkshopTestData/workshop-missing-notes"), headCommitSha: "abcde"))
    XCTAssertThrowsError(try Workshop(localPath: try! getTestResourcePath(at: "WorkshopTestData/workshop-missing-tags"), headCommitSha: "abcde"))
  }

  func testDoubleBackground() {
    XCTAssertThrowsError(try Workshop(localPath: try! getTestResourcePath(at: "WorkshopTestData/workshop-double-bg"), headCommitSha: "abcde"))
  }

  static var allTests : [(String, (WorkshopTests) -> () throws -> Void)] {
    return [
      ("testParse", testParse),
      ("testMissingDetails", testMissingDetails),
      ("testDoubleBackground", testDoubleBackground)
    ]
  }
}
