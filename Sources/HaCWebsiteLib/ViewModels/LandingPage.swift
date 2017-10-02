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
            El.P.containing("We are a community focused on learning about, and building things with technology."),
            El.A[Attr.href => "http://eepurl.com/ckeD2b"].containing(
              El.Div[Attr.className => "LandingIntroduction__callToActionButton"].containing(
                "Join our mailing list"
              )
            ),
            El.Div[Attr.className => "LandingIntroduction__social"].containing(
              El.Div[Attr.className => "LandingIntroduction__socialText"].containing("And find us on"),
              El.Div[Attr.className => "LandingIntroduction__socialIconRow"].containing(
                El.A[Attr.href => "https://github.com/hackersatcambridge/", Attr.className => "LandingIntroduction__socialLinkIcon"].containing(
                  El.Img[
                    Attr.className => "LandingIntroduction__socialLinkIconImg",
                    Attr.src => "/static/images/github_icon.svg",
                    Attr.alt => "GitHub"
                  ]
                ),
                El.A[Attr.href => "https://www.facebook.com/hackersatcambridge", Attr.className => "LandingIntroduction__socialLinkIcon"].containing(
                  El.Img[
                    Attr.className => "LandingIntroduction__socialLinkIconImg",
                    Attr.src => "/static/images/facebook_icon.svg",
                    Attr.alt => "Facebook"
                  ]
                ),
                El.A[Attr.href => "https://www.youtube.com/channel/UCNY6ekV9z84ZYL4qUDusTFw", Attr.className => "LandingIntroduction__socialLinkIcon"].containing(
                  El.Img[
                    Attr.className => "LandingIntroduction__socialLinkIconImg",
                    Attr.src => "/static/images/youtube_icon.svg",
                    Attr.alt => "YouTube"
                  ]
                ),
                El.A[Attr.href => "https://medium.com/hackers-at-cambridge", Attr.className => "LandingIntroduction__socialLinkIcon"].containing(
                  El.Img[
                    Attr.className => "LandingIntroduction__socialLinkIconImg",
                    Attr.src => "/static/images/medium_icon.svg",
                    Attr.alt => "Medium"
                  ]
                )
              )
            )
          ),
          El.Section[Attr.className => "LandingFeature LandingTop__feature"].containing(
            El.H1[Attr.className => "LandingFeature__subtitle Text--sectionHeading"].containing("Featured"),
            El.Div[Attr.className => "LandingFeature__hero"].containing(
              El.H2.containing("Hero goes here")
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
