import HaCTML
import Foundation

extension LandingFeatures {
  static var bashWorkshop: LandingFeature {
    return EventFeature(
      startDate: Date.from(year: 2017, month: 10, day: 25, hour: 19, minute: 00),
      endDate: Date.from(year: 2017, month: 10, day: 25, hour: 20, minute: 30),
      eventLink: "https://www.facebook.com/events/245447659318325",
      liveLink: "/bash",
      hero: ImageHero(
        background: .image("/static/images/bash-bg.jpg"),
        imagePath: "/static/images/bash-text.svg",
        alternateText: "HaC Tools for Programmers: Bash on 25 October"
      ),
      textShade: .light
    )
  }
}
