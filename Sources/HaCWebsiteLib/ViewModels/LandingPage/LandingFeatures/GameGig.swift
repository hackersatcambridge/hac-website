import HaCTML
import Foundation

extension LandingFeatures {
  static var gameGig: LandingFeature {
    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2017, month: 12, day: 01, hour: 10, minute: 00),
        duration: 12 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/124219834921040",
      liveLink: "/event/game-gig-2017",
      hero: ImageHero(
        background: .image("/static/images/game-gig-bg.jpg"),
        imagePath: "/static/images/game-gig-text.svg",
        alternateText: "HaC Game Gig 80's, on the 1st of December 2017!"
      ),
      textShade: .light
    )
  }
}
