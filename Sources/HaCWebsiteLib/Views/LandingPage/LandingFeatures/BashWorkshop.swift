import HaCTML
import Foundation

extension LandingFeatures {
  static var bashWorkshop: LandingFeature {
    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2017, month: 10, day: 25, hour: 19, minute: 00),
        duration: 1.5 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/245447659318325",
      liveLink: "/bash",
      hero: ImageHero(
        background: .image(Assets.publicPath("/images/bash-bg.jpg")),
        imagePath: Assets.publicPath("/images/bash-text.svg"),
        alternateText: "HaC Tools for Programmers: Bash on 25 October"
      ),
      textShade: .light
    )
  }
}
