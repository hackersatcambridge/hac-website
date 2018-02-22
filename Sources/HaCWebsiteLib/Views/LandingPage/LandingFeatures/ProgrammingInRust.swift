import HaCTML
import Foundation

extension LandingFeatures {
  static var programmingInRust: LandingFeature {
    return EventFeature(
      eventPeriod: DateInterval(
        start: Date.from(year: 2017, month: 11, day: 9, hour: 13, minute: 00),
        duration: 1.5 * 60 * 60
      ),
      eventLink: "https://www.facebook.com/events/832214590292163",
      liveLink: "https://github.com/hackersatcambridge/intro-to-rust-workshop",
      hero: ImageHero(
        background: .image(Assets.publicPath("/images/rustbg.png")),
        imagePath: Assets.publicPath("/images/rustfg.png"),
        alternateText: "HaC Programming in Rust on 9 November"
      )
    )
  }
}
