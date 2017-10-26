import HaCTML

extension LandingFeatures {
  struct IntroToProgramming1: Nodeable {
    var node: Node {
      return ImageHero(
        background: .color("#2e5daf"),
        imagePath: "/static/images/intro1feature.jpg",
        alternateText: "HaC Intro to Programming Workshop on 18 October",
        destinationURL: "https://www.hackersatcambridge.com/intro-to-programming"
      ).node
    }
  }
}
