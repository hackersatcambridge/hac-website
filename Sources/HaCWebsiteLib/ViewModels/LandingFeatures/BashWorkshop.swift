import HaCTML
import Foundation

extension LandingFeatures {
  struct BashWorkshop {
    let facebookLink = "https://www.facebook.com/events/245447659318325"
    let descriptionLink = "/bash"

    /// Returns a link to the most currently relevant information about this workshop
    var link: String {
      // 2017-10-25 18:45
      let workshopStartDate = Date(timeIntervalSince1970: 1508953500)
      let currentDate = Date()
      if workshopStartDate < currentDate {
        return descriptionLink
      } else {
        return facebookLink
      }
    }

    var node: Node {
      return ImageHero(
        background: .color("#04101f"),
        imagePath: "/static/images/bash.png",
        alternateText: "HaC Tools for Programmers: Bash on 25 October",
        destinationURL: link
      ).node
    }
  }
}
