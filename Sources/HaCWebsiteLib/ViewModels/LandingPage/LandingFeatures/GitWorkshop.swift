import HaCTML
import Foundation

extension LandingFeatures {
  static var gitWorkshop: LandingFeature {
    return EventFeature(
      startDate: Date.from(year: 2017, month: 11, day: 1, hour: 19, minute: 00),
      endDate: Date.from(year: 2017, month: 11, day: 1, hour: 20, minute: 30),
      eventLink: "https://www.facebook.com/events/1906244696304681",
      liveLink: nil, // TODO
      hero: ImageHero(
        background: .color("#F1283B"),
        imagePath: "/static/images/git-foreground.svg",
        alternateText: "HaC Tools for Programmers: Bash on 25 October"
      ),
      textShade: .light
    )
  }
}
