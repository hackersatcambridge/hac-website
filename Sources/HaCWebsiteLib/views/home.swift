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
  return E.Div[A.className => "LandingUpdateFeed__item"].c(
    E.Div[A.className => "PostCard"].c(
      E.Span[A.className => "PostCard__label"].c(labelFor(updateType: type)),
      E.H3[A.className => "PostCard__title"].c(title)
    )
  )
}

extension UI.Pages {
  static func home() -> Node {
    return UI.Pages.base(
      title: "Hackers at Cambridge",
      content: Fragment(
        E.Div[A.className => "LandingTop"].c(
          E.Header[A.className => "LandingIntroduction LandingTop__introduction"].c(
            E.Div.c("LandingIntroduction__titleContainer").c(
              E.Img[A.className => "LandingIntroduction__titleImage", A.src => "/static/images/hac-logo-dark.svg", A.alt => "Hackers at Cambridge"],
              E.Div[A.className => "LandingIntroduction__tagLine"].c("Cambridge's student tech society")
            ),
            E.P.c("We build things, and help other people build things. We also have a bunch of fun"),
            E.A[A.href => "#", A.className => "LandingIntroduction__link"].c("Find out more")
          ),
          E.Section[A.className => "LandingFeature LandingTop__Feature"].c(
            E.H1[A.className => "LandingFeature__subtitle"].c("Featured"),
            E.Div[A.className => "LandingFeature__hero"].c(
              E.H2.c("Hero goes here")
            )
          )
        ),
        E.Section[A.className => "LandingUpdateFeed"].c(
          updateFeedItem(type: .workshop, title: "Conquering Linux"),
          updateFeedItem(type: .video, title: "Partial Recursive Functions 1/5: What are functions?")
        ),
        E.Article[A.className => "LandingAbout"].c(
          E.H3.c("Who we are"),
          E.P.c("This is where we talk about ourselves a lot. Yay us! Aren't we just a lovely bunch of folks with a lovely society that everybody should get involved with!")
        )
      )
    )
  }
}
