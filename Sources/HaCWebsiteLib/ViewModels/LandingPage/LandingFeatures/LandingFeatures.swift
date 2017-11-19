import Foundation

enum LandingFeatures {
  /// Features in ascending order of date
  static let features: [LandingFeature] = [
    LandingFeatures.introToProgramming1,
    LandingFeatures.introToProgramming2,
    LandingFeatures.bashWorkshop,
    LandingFeatures.gitWorkshop,
    LandingFeatures.introToProgramming3,
    LandingFeatures.programmingInRust,
    LandingFeatures.introToProgramming4,
    LandingFeatures.gamesWithLove
  ]

  /// Gets the most currently appropriate feature
  static var currentFeature: LandingFeature? {
    let currentDate = Date()
    return features.first { $0.expiryDate > currentDate }
  }
}
