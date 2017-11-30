import HaCTML

// swiftlint:disable line_length

struct LandingUpdateFeed {
  let updates: [PostCard]

  var node: Node {
    return UI.Pages.base(
      title: "Hackers at Cambridge",
      content: Fragment(
        El.Section[Attr.className => "LandingUpdateFeed"].containing(
          El.Div[Attr.className => "LandingUpdateFeed__postContainer"].containing(
            updates.map {
              El.Div[Attr.className => "LandingUpdateFeed__item"].containing($0)
            }
          )
        )
      )
    )
  }
}
