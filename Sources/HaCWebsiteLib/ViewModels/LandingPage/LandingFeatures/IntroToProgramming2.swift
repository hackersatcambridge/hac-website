import HaCTML
import Foundation

extension LandingFeatures {
  static var introToProgramming2: LandingFeature {
    return EventFeature(
      startDate: Date.from(year: 2017, month: 10, day: 23, hour: 19, minute: 00),
      endDate: Date.from(year: 2017, month: 10, day: 23, hour: 20, minute: 30),
      eventLink: "https://www.facebook.com/events/131007020886907",
      liveLink: "/intro-to-programming",
      hero: ImageHero(
        background: .color("#eb7b1f"),
        imagePath: "/static/images/intro2feature.jpg",
        alternateText: "HaC Intro to Programming Workshop on 23 October"
      ),
      textShade: .light
    )
  }
}

