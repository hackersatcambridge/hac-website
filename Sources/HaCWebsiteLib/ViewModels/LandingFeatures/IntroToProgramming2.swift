import HaCTML

extension LandingFeatures {
  struct IntroToProgramming2: Nodeable {
    var node: Node {
      return ImageHero(
        background: .color("#eb7b1f"),
        imagePath: "/static/images/intro2feature.jpg",
        alternateText: "HaC Intro to Programming Workshop on 23 October",
        destinationURL: "https://www.hackersatcambridge.com/intro-to-programming"
      ).node
    }
  }
}
