import HaCTML
import Foundation

extension LandingFeatures {
  static var gitWorkshop: LandingFeature {
    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2017, month: 11, day: 1, hour: 19, minute: 00),
        duration: 1.5 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/1906244696304681",
      liveLink: "/git",
      hero: ImageHero(
        background: .color("#F1283B"),
        imagePath: Assets.publicPath("/images/git-foreground.svg"),
        alternateText: "HaC Tools for Programmers: Bash on 25 October"
      ),
      textShade: .light
    )
  }
}
