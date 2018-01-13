import HaCTML

// swiftlint:disable line_length

struct WorkshopsIndexPage {

  let upcomingWorkshops: [PostCard]
  let previousWorkshops: [PostCard]

  let demonstratorsGroupUrl = "https://www.facebook.com/groups/1567785333234852/"

  var node: Node {
    return Page(
      title: "Hackers at Cambridge",
      content: El.Div[Attr.className => "WorkshopsIndexPage"].containing(
        BackBar(),
        WorkshopsIndexAbout(),
        WorkshopsIndexSchedule(),
        WorkshopsIndexGetInvolved()
      )
    ).node
  }

  private var previous: Node {
    return El.Div[Attr.className => "WorkshopsPrevious"].containing(
      El.H1[Attr.className => "Text--sectionHeading"].containing("Previous"),
      El.Div[Attr.className => "WorkshopsPrevious__cards"].containing(previousWorkshops)
    )
  }
}
