import HaCTML
import Foundation

extension LandingFeatures {
  static var openSourceWorkshop: LandingFeature? {
    guard let hero = WorkshopManager.workshops["open-source"]?.hero else {
      return nil
    }

    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2018, month: 2, day: 15, hour: 13, minute: 00),
        duration: 1.5 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/1980238595569777/",
      liveLink: "/workshops/open-source",
      hero: hero
    )
  }
}
