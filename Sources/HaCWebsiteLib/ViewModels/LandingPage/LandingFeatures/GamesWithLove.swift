import HaCTML
import Foundation

extension LandingFeatures {
  static var gamesWithLove: LandingFeature {
    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2017, month: 11, day: 29, hour: 16, minute: 00),
        duration: 1.75 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/128537371191407",
      liveLink: "/love",
      hero: ImageHero(
        background: .image(Assets.publicPath("/images/love/bg.png")),
        imagePath: Assets.publicPath("/images/love/fg.svg"),
        alternateText: "HaC Make games quickly with LÖVE on the 29th of November"
      ),
      textShade: .light
    )
  }
}
