import HaCTML
import Foundation

extension LandingFeatures {
  static var gameGig: LandingFeature {
    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2017, month: 12, day: 01, hour: 10, minute: 00),
        duration: 10 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/124219834921040/",
      liveLink: "/game-gig",
      hero: ImageHero(
        background: .image("/static/images/gamegig-bg.png"),
        imagePath: "/static/images/gamegig.svg",
        alternateText: "HaC Game Gig 3000 on the 1st of December 2017!"
      ),
      textShade: .light
    )
  }
}
