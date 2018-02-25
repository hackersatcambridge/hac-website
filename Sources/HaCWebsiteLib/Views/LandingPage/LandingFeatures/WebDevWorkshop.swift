import HaCTML
import Foundation

private func createWebDevWorkshop(month: Int, day: Int, eventLink: String) -> LandingFeature? {
  guard let hero = WorkshopManager.workshops["web-dev"]?.hero else {
    return nil
  }

  return EventFeature(
    eventPeriod: DateInterval(
      start: Date.from(year: 2018, month: month, day: day, hour: 19, minute: 15),
      duration: 1.5 * 60 * 60
    ),
    eventLink: eventLink,
    liveLink: "/workshops/web-dev",
    hero: hero
  )
}

extension LandingFeatures {
  static var webDevWorkshop1: LandingFeature? {
    return createWebDevWorkshop(
      month: 2,
      day: 19,
      eventLink: "https://www.facebook.com/events/2147905152097397/?event_time_id=2147905162097396"
    )
  }

  static var webDevWorkshop2: LandingFeature? {
    return createWebDevWorkshop(
      month: 2,
      day: 26,
      eventLink: "https://www.facebook.com/events/2147905152097397/?event_time_id=2147905165430729"
    )
  }

  static var webDevWorkshop3: LandingFeature? {
    return createWebDevWorkshop(
      month: 3,
      day: 5,
      eventLink: "https://www.facebook.com/events/2147905152097397/?event_time_id=2147905168764062"
    )
  }
}
