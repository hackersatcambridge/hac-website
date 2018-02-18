import Foundation

enum LandingFeatures {
  /// Features in ascending order of date
  static let features: [LandingFeature?] = [
    LandingFeatures.introToProgramming1,
    LandingFeatures.introToProgramming2,
    LandingFeatures.bashWorkshop,
    LandingFeatures.gitWorkshop,
    LandingFeatures.introToProgramming3,
    LandingFeatures.programmingInRust,
    LandingFeatures.introToProgramming4,
    LandingFeatures.binaryExploitation,
    LandingFeatures.gamesWithLove,
    LandingFeatures.gameGig,
    LandingFeatures.introToUnity,
    LandingFeatures.continuousIntegrationWorkshop,
    LandingFeatures.emacsWorkshop,
    LandingFeatures.introToSwiftWorkshop,
    LandingFeatures.openSourceWorkshop,
    LandingFeatures.pythonML,
    LandingFeatures.webDevWorkshop1,
    LandingFeatures.webDevWorkshop2,
    LandingFeatures.webDevWorkshop3
  ]

  /// Gets the most currently appropriate feature
  static var currentFeature: LandingFeature? {
    let currentDate = Date()

    // We want to return the first non-nil LandingFeature whose expiry date is
    // after the current date. As the list itself is a list of optionals, we
    // need to convert it to a list of non-optionals using flatMap first (as
    // otherwise a value of type double-optional is returned.)
    return  features.flatMap{ $0 }.first { $0.expiryDate > currentDate }
  }
}
