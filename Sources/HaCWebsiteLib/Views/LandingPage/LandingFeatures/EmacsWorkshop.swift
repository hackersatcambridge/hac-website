import HaCTML
import Foundation

extension LandingFeatures {
  static var emacsWorkshop: LandingFeature? {
    guard let hero = WorkshopManager.workshops["emacs"]?.hero else {
        return nil
    }

    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2018, month: 2, day: 8, hour: 19, minute: 15),
        duration: 1.5 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/415154248916702/",
      liveLink: "/workshops/emacs",
      hero: hero,
      textShade: .light
    )
  }
}
