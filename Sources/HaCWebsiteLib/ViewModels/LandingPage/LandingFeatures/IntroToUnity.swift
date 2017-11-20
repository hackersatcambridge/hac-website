import HaCTML
import Foundation

extension LandingFeatures {
  static var introToUnity: LandingFeature {
    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2017, month: 12, day: 01, hour: 10, minute: 00),
        duration: 1 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/887062184790929/",
      liveLink: nil,
      hero: ImageHero(
        background: .image("/static/images/introtounity-bg.png"),
        imagePath: "/static/images/introtounity.svg",
        alternateText: "Intro to Unity on the 1st of December"
      ),
      textShade: .dark
    )
  }
}