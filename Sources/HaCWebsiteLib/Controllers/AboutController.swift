import Kitura
import HaCTML
import LoggerAPI
import HeliumLogger
import DotEnv
import SwiftyJSON

struct AboutController {
  static var handler: RouterHandler = { request, response, next in
    var content: Node {
      return El.Div[Attr.className => "LandingAbout__text", 
                    Attr.style => ["margin": "0% 15%"]
              ].containing(
              El.H1[Attr.className => "LandingAbout__subtitle Text--sectionHeading"].containing("About Hacker's at Cambridge"),
              Markdown("""
                Hacker's at Cambridge are a technology society aimed at promoting a culture of creators and innovators in Cambridge. We organise workshops, events and talks for any student in Cambridge who wants to take part, fostering a collaborative culture.
              
                The main committee members include Timothy Lazarus, Eliot Lim, Mukul Rathi, Hari Prasad and Patrick Ferris.
              """))
    }

    try response.send(
      Page(
        title: "About Hacker's at Cambridge",
        content: Fragment(
          BackBar(backLinkText: "Home", backLinkURL: "/"),
          content
        )
      ).node.render()
    ).end()
  }
}
