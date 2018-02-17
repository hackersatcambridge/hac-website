import HaCTML
import Foundation

extension LandingFeatures {
  static var introToSwiftWorkshop: LandingFeature? {
    guard let hero = WorkshopManager.workshops["intro-to-swift"]?.hero else {
        return nil
    }

    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2018, month: 2, day: 12, hour: 19, minute: 15),
        duration: 1.5 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/1701011496625250/",
      liveLink: "/workshops/intro-to-swift",
      hero: hero,
      textShade: .light
    )
  }
}
