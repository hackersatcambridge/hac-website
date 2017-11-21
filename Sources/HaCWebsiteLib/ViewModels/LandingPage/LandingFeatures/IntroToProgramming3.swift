import HaCTML
import Foundation

extension LandingFeatures {
  static var introToProgramming3: LandingFeature {
    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2017, month: 11, day: 6, hour: 19, minute: 00),
        duration: 1.5 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/131007020886907",
      liveLink: "/intro-to-programming",
      hero: ImageHero(
        background: .color("#e6e6e6"),
        imagePath: Assets.publicPath("/images/intro3feature.svg"),
        alternateText: "HaC Intro to Programming Workshop on 6 November"
      ),
      textShade: .dark
    )
  }
}
