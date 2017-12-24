import HaCTML

// swiftlint:disable line_length

struct WorkshopsPage {

  let upcomingWorkshops: [PostCard]
  let previousWorkshops: [PostCard]

  let demonstratorsGroupUrl = "https://www.facebook.com/groups/1567785333234852/"

  var introduction: Node {
    return Fragment(

      El.H1.containing("Workshops"),
      Markdown("""
        Run by members of the community and open to everyone, our workshops aim to inspire and to teach practical technology skills.
      """)
    )
  }

  var searchBar: Node {
    return El.Div.containing(
      El.Input[Attr.type => "text", Attr.placeholder => "Search workshops"]
    )
  }

  var upcoming: Node {
    return El.Div[Attr.className => "WorkshopsUpcoming"].containing(
      El.H1[Attr.className => "Text--sectionHeading"].containing("Upcoming"),
      El.Div[Attr.className => "WorkshopsUpcoming__cards"].containing(upcomingWorkshops)
    )
  }

  var previous: Node {
    return El.Div[Attr.className => "WorkshopsPrevious"].containing(
      El.H1[Attr.className => "Text--sectionHeading"].containing("Previous"),
      El.Div[Attr.className => "WorkshopsPrevious__cards"].containing(previousWorkshops)
    )
  }

  var getInvolved: Node {
    return El.Div[Attr.className => "WorkshopsGetInvolved"].containing(
      El.H2.containing("Get involved"),
      Markdown("""
        Hackers at Cambridge workshops are developed by the community.
        If you have an idea for a workshop you'd like to run, or if you'd like to help produce high quality workshops, join us on our [workshoppers Facebook group](\(demonstratorsGroupUrl))
      """)
    )
  }

  var node: Node {
    return UI.Pages.base(
      title: "Hackers at Cambridge",
      content: Fragment(
        introduction, // What are workshops?
        searchBar, // Find interesting workshops
        upcoming, // What workshops are coming soon
        previous, // Previously run workshops for interested parties to see
        getInvolved // How to get involved with workshops
      )
    )
  }
}
