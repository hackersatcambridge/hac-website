import HaCTML
import Foundation

extension LandingFeatures {
  static var pythonML: LandingFeature? {
    guard let hero = WorkshopManager.workshops["python-ml"]?.hero else {
      return nil
    }

    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2018, month: 2, day: 15, hour: 17, minute: 00),
        duration: 3 * 60 * 60
      ),
      eventLink: "/workshops/python-ml",
      liveLink: "/workshops/python-ml",
      hero: hero
    )
  }
}
