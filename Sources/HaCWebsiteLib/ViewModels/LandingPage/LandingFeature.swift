import Foundation
import HaCTML
protocol LandingFeature: Nodeable {
  var node: Node { get }
  /// The date after which the feature should no longer be shown
  var expiryDate: Date { get }
}
