import HaCTML

// swiftlint:disable line_length

struct WorkshopsIndexPage {

  let allWorkshops: [Workshop]

  let demonstratorsGroupUrl = "https://www.facebook.com/groups/1567785333234852/"

  var node: Node {
    return Page(
      title: "Hackers at Cambridge",
      content: El.Div[Attr.className => "WorkshopsIndexPage"].containing(
        BackBar(backLinkText: "Home", backLinkURL: "/"),
        WorkshopsIndexAbout(),
        WorkshopsIndexArchive(workshops: allWorkshops),
        // WorkshopsIndexSchedule(),
        WorkshopsIndexGetInvolved()
      )
    ).node
  }
}
