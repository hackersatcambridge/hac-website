import HaCTML
import Foundation

extension LandingFeatures {
  static var introToProgramming2: LandingFeature {
    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2017, month: 10, day: 23, hour: 19, minute: 00),
        duration: 1.5 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/131007020886907",
      liveLink: "/intro-to-programming",
      hero: ImageHero(
        background: .color("#eb7b1f"),
        imagePath: Assets.publicPath("/images/intro2feature.jpg"),
        alternateText: "HaC Intro to Programming Workshop on 23 October"
      )
    )
  }
}
