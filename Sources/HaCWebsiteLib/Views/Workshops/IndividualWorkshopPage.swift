import HaCTML
import Foundation

// swiftlint:disable line_length

struct IndividualWorkshopPage {
  let workshop: Workshop

  var node: Node {
    return Page(
      title: "\(workshop.title) | Hackers at Cambridge",
      content: Fragment(
        BackBar(backLinkText: "Workshops", backLinkURL: "/workshops"),
        hero, // A big beautiful header
        description, // Who, What, Why
        content, // The content of the workshop
        furtherReading
      )
    ).node
  }

  var hero: Node {
    return El.Div[Attr.className => "WorkshopHero"].containing(
      workshop.hero
    )
  }

  var description: Node {
    return El.Div[Attr.className => "WorkshopDescription"].containing([
      El.H1[Attr.className => "WorkshopDescription__title Text--headline"].containing(workshop.title),
      El.Div[Attr.className => "WorkshopDescription__descriptionText"].containing(workshop.description),
      El.Div[Attr.className => "WorkshopDescription__detail"].containing([
        El.H1[Attr.className => "Text--sectionHeading"].containing("Prerequisites"),
        workshop.prerequisites
      ]),
      El.Div[Attr.className => "WorkshopDescription__detail"].containing([
        El.H1[Attr.className => "Text--sectionHeading"].containing("Set up instructions"),
        workshop.setupInstructions
      ]),
      El.Div[Attr.className => "WorkshopDescription__detail"].containing(contributors)
    ])
  }

  var contributors: Nodeable {
    let contributorsText = workshop.contributors.isEmpty ? nil : "Contributors: " + workshop.contributors.joined(separator: ", ")
    let thanksText = workshop.thanks.isEmpty ? nil : "Thanks to: " + workshop.thanks.joined(separator: ", ")

    return Fragment(
      contributorsText,
      El.Br,
      thanksText
    )
  }

  var slidesButton: Node? {
    return workshop.slidesLink.map {
      El.A[Attr.href => $0.absoluteString, Attr.target => "_blank"].containing(
        El.Div[Attr.className => "BigButton BigButton--inline"].containing(
          "View slides"
        )
      )
    }
  }

  var recordingButton: Node? {
    return workshop.recordingLink.map {
      El.A[Attr.href => $0.absoluteString, Attr.target => "_blank"].containing(
        El.Div[Attr.className => "BigButton BigButton--inline BigButton--youtube"].containing(
          "View video recording"
        )
      )
    }
  }

  var examplesButton: Node? {
    return workshop.examplesLink.map {
      El.A[Attr.href => $0.absoluteString, Attr.target => "_blank"].containing(
        El.Div[Attr.className => "BigButton BigButton--inline BigButton--github"].containing(
          "View code examples on GitHub"
        )
      )
    }
  }

  var content: Node {
    return El.Div[Attr.className => "WorkshopContent"].containing(
      slidesButton, recordingButton, examplesButton,
      workshop.notes
    )
  }

  var furtherReading: Node? {
    if workshop.furtherReadingLinks.isEmpty {
      return nil
    } else {
      return El.Div[Attr.className => "WorkshopFurtherReading"].containing(
        El.H1[Attr.className => "Text--sectionHeading"].containing("Further reading"),
        El.Ul.containing(
          workshop.furtherReadingLinks.map {
            El.A[Attr.href => $0.url.absoluteString].containing(
              El.Li.containing($0.text)
            )
          }
        )
      )
    }
  }
}
