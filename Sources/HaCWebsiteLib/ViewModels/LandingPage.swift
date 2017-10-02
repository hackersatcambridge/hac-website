import HaCTML

// swiftlint:disable line_length

struct LandingPage {
  let updates: [PostCard]

  var node: Node {
    return UI.Pages.base(
      title: "Hackers at Cambridge",
      content: Fragment(
        El.Div[Attr.className => "LandingTop"].containing(
          El.Header[Attr.className => "LandingIntroduction LandingTop__introduction"].containing(
            El.Div[Attr.className => "LandingIntroduction__titleContainer"].containing(
              El.Img[
                Attr.className => "LandingIntroduction__titleImage",
                Attr.src => "/static/images/hac-logo-dark.svg",
                Attr.alt => "Hackers at Cambridge"
              ],
              El.Div[Attr.className => "LandingIntroduction__tagLine"].containing("Cambridge's student tech society")
            ),
            El.P.containing("We build things, and help other people build things. We also have a bunch of fun"),
            El.A[Attr.href => "#", Attr.className => "LandingIntroduction__link"].containing("Find out more"),
            El.Div[Attr.className => "LandingIntroduction__titleIconRow"].containing(
              El.A[Attr.href => "https://github.com/hackersatcambridge/", Attr.className => "LandingIntroduction__titleLinkIcon"].containing(
                El.Img[
                  Attr.className => "LandingIntroduction__titleLinkIconImg",
                  Attr.src => "/static/images/github_icon.svg",
                  Attr.alt => "GitHub"
                ]
              ),
              El.A[Attr.href => "https://www.facebook.com/hackersatcambridge", Attr.className => "LandingIntroduction__titleLinkIcon"].containing(
                El.Img[
                  Attr.className => "LandingIntroduction__titleLinkIconImg",
                  Attr.src => "/static/images/facebook_icon.svg",
                  Attr.alt => "Facebook"
                ]
              ),
              El.A[Attr.href => "https://twitter.com/hackersatcam", Attr.className => "LandingIntroduction__titleLinkIcon"].containing(
                El.Img[
                  Attr.className => "LandingIntroduction__titleLinkIconImg",
                  Attr.src => "/static/images/twitter_icon.svg",
                  Attr.alt => "Twitter"
                ]
              ),
              El.A[Attr.href => "https://www.youtube.com/channel/UCNY6ekV9z84ZYL4qUDusTFw", Attr.className => "LandingIntroduction__titleLinkIcon"].containing(
                El.Img[
                  Attr.className => "LandingIntroduction__titleLinkIconImg",
                  Attr.src => "/static/images/youtube_icon.svg",
                  Attr.alt => "YouTube"
                ]
              ),
              El.A[Attr.href => "https://medium.com/hackers-at-cambridge", Attr.className => "LandingIntroduction__titleLinkIcon"].containing(
                El.Img[
                  Attr.className => "LandingIntroduction__titleLinkIconImg",
                  Attr.src => "/static/images/medium_icon.svg",
                  Attr.alt => "Medium"
                ]
              )
            )
          ),
          El.Section[Attr.className => "LandingFeature LandingTop__feature"].containing(
            El.H1[Attr.className => "LandingFeature__subtitle Text--sectionHeading"].containing("Featured"),
            El.Div[Attr.className => "LandingFeature__hero"].containing(
              ImageHero(backgroundColor: "#8900AC", imagePath: "/static/images/hac_squash.svg", alternateText: "HaC Squash on 12 October").node
            )
          )
        ),
        El.Section[Attr.className => "LandingUpdateFeed"].containing(
          El.H1[Attr.className => "LandingUpdateFeed__title Text--sectionHeading"].containing("Updates"),
          El.Div[Attr.className => "LandingUpdateFeed__postContainer"].containing(
            updates.map {
              El.Div[Attr.className => "LandingUpdateFeed__item"].containing($0.node)
            }
          )
        ),
        El.Article[Attr.className => "LandingAbout"].containing(
          El.Div[Attr.className => "LandingAbout__imageContainer"].containing(
            El.Img[
              Attr.className => "LandingAbout__image",
              Attr.src => "/static/images/whoishac.jpg"
            ]
          ),
          El.Div[Attr.className => "LandingAbout__text"].containing(
            El.H1[Attr.className => "LandingAbout__subtitle Text--sectionHeading"].containing("About"),
            El.H2[Attr.className => "LandingAbout__headline"].containing("Who are Hackers at Cambridge?"),
            El.P.containing(
              "This is where we talk about ourselves a lot. Yay us! Aren't we just a lovely bunch of folks with a lovely society that everybody should get involved with!"
            )
          )
        )
      )
    )
  }
}
