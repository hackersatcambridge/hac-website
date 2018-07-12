import HaCTML

// swiftlint:disable line_length

struct EventsPage: Nodeable {

  var node: Node {
    return Page(
      title: "Events",
      content: Fragment(
        El.Div[Attr.className => "LandingTop"].containing("hello")
      )
    ).node
  }
}
