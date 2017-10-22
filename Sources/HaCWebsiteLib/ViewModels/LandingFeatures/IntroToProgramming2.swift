import HaCTML

extension LandingFeatures {
  struct IntroToProgramming2 {
    var node: Node {
      return ImageHero(
        background: .color("#eb7b1f"),
        imagePath: "/static/images/intro2feature.jpg",
        alternateText: "HaC Intro to Programming Workshop on 23 October",
        destinationURL: "https://www.facebook.com/events/131007020886907"
      ).node
    }
  }
}
