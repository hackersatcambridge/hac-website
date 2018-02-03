import HaCTML
import Foundation

extension LandingFeatures {
  static var continuousIntegrationWorkshop: LandingFeature {
    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2018, month: 2, day: 15, hour: 13, minute: 15    ),
        duration: 1.5 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/181764052556196/",
      liveLink: "/workshops/continuous-integration",
      hero: WorkshopManager.workshops["workshop-continuous-integration"]!.hero,
      textShade: .light
    )
  }
}
