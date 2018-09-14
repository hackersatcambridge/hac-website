import HaCTML
import Foundation

extension LandingFeatures {
  static var greenHack: LandingFeature {
    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2018, month: 03, day: 10, hour: 10, minute: 00),
        duration: 12 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/694391484282782/",
      liveLink: "/greenhack",
      hero: ImageHero(
        background: .image(Assets.publicPath("/images/green_hack/bg.png")),
        imagePath: Assets.publicPath("images/green_hack/fg.png"),
        alternateText: "GreenHack Sustainability Hackathon on the 10th of March 2018"
      )
    )
  }
}
