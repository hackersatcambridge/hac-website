import HaCTML

private enum UpdateType {
  case workshop
  case video
}

private func labelFor(updateType: UpdateType) -> String {
  switch (updateType) {
  case .workshop:
    return "Workshop"
  case .video:
    return "Video"
  }
}

private func updateFeedItem(type: UpdateType, title: String) -> Node {
  return El.Div[Attr.className => "LandingUpdateFeed__item"].containing(
    El.Div[Attr.className => "PostCard"].containing(
      El.Span[Attr.className => "PostCard__label"].containing(labelFor(updateType: type)),
      El.H3[Attr.className => "PostCard__title"].containing(title)
    )
  )
}

extension UI.Pages {
  static func home() -> Node {
    return UI.Pages.base(
      title: "Hackers at Cambridge",
      content: Fragment(
        El.Div[Attr.className => "LandingTop"].containing(
          El.Header[Attr.className => "LandingIntroduction LandingTop__introduction"].containing(
            El.Div[Attr.className => "LandingIntroduction__titleContainer"].containing(
              El.Img[Attr.className => "LandingIntroduction__titleImage", Attr.src => "/static/images/hac-logo-dark.svg", Attr.alt => "Hackers at Cambridge"],
              El.Div[Attr.className => "LandingIntroduction__tagLine"].containing("Cambridge's student tech society")
            ),
            El.P.containing("We build things, and help other people build things. We also have a bunch of fun"),
            El.A[Attr.href => "#", Attr.className => "LandingIntroduction__link"].containing("Find out more")
          ),
          El.Section[Attr.className => "LandingFeature LandingTop__Feature"].containing(
            El.H1[Attr.className => "LandingFeature__subtitle"].containing("Featured"),
            El.Div[Attr.className => "LandingFeature__hero"].containing(
              El.H2.containing("Hero goes here")
            )
          )
        ),
        El.Section[Attr.className => "LandingUpdateFeed"].containing(
          updateFeedItem(type: .workshop, title: "Conquering Linux"),
          updateFeedItem(type: .video, title: "Partial Recursive Functions 1/5: What are functions?")
        ),
        El.Article[Attr.className => "LandingAbout"].containing(
          El.H3.containing("Who we are"),
          El.P.containing("This is where we talk about ourselves a lot. Yay us! Aren't we just a lovely bunch of folks with a lovely society that everybody should get involved with!")
        )
      )
    )
  }
}
