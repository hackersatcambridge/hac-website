import HaCTML
import Foundation

extension LandingFeatures {
  struct BashWorkshop: Nodeable {
    let facebookLink = "https://www.facebook.com/events/245447659318325"
    let descriptionLink = "/bash"
    // 2017-10-25 18:45
    let workshopStartDate = Date(timeIntervalSince1970: 1508953500)

    /// Returns a link to the most currently relevant information about this workshop
    var link: String {
      let currentDate = Date()
      if workshopStartDate < currentDate {
        return descriptionLink
      } else {
        return facebookLink
      }
    }

    var node: Node {
      return ImageHero(
        background: .image("/static/images/bash-bg.jpg"),
        imagePath: "/static/images/bash-text.svg",
        alternateText: "HaC Tools for Programmers: Bash on 25 October",
        destinationURL: link,
        dateToDisplay: workshopStartDate
      ).node
    }
  }
}
