import HaCTML

// swiftlint:disable line_length

// TODO: investigate if the information here can be extracted from the landing feature
struct GameGig2017: Hackathon {
  let youtubeUrl = "sgsagsgs"
  let gameEngines = [
    "Unreal Engine": "https://www.youtube.com/hackersatcambridge",
    "Unity": "link to unity",
    "Love2D": "link to love2D",
    "GameMaker": "link to gamemaker"
  ]

  var node: Node {
    return UI.Pages.base(
      title: "Hackers at Cambridge",
      content: Fragment(
        El.Div[Attr.className => "LandingTop"].containing("TOP"),
        // El.Section[Attr.className => "LandingUpdateFeed"].containing(
        //   El.H1[Attr.className => "LandingUpdateFeed__title Text--sectionHeading"].containing("Updates"),
        //   El.Div[Attr.className => "LandingUpdateFeed__postContainer"].containing(
        //     updates.map {
        //       El.Div[Attr.className => "LandingUpdateFeed__item"].containing($0.node)
        //     }
        //   )
        // ),
        El.Article[Attr.className => "LandingAbout", Attr.id => "about"].containing("About")
      )
    )
  }
}
