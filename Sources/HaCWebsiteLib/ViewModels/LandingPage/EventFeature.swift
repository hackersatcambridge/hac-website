import Foundation
import HaCTML
/// A landing page feature for events
struct EventFeature: LandingFeature {
  /// The span of time when the event is happening
  let eventPeriod: DateInterval

  /// The link to use in the lead up to the event (e.g. Facebook event link)
  let eventLink: String

  /// The link to use whilst the event is happening
  let liveLink: String?
  let hero: Nodeable
  let textShade: TextShade

  enum TextShade {
    case dark
    case light
    var styleClass: String {
      switch self {
        case .light:
          return "EventFeature--text-light"
        case .dark:
          return "EventFeature--text-dark"
      }
    }
  }

  var dateBlock: Nodeable {
    return El.Div[Attr.className => "EventFeature__date"].containing(
      DateUtils.individualDayFormatter.string(from: eventPeriod.start)
    )
  }

  var expiryDate: Date {
    /// Expire 2 hours after event finish
    return eventPeriod.end + 2 * 60 * 60
  }

  /// Returns a link to the most currently relevant information about this event
  var currentLink: String {
    guard let liveLink = liveLink else { return eventLink }

    let currentDate = Date()
    let startPadding: TimeInterval = 15 * 60 // 15 mins
    let endPadding: TimeInterval = 60 * 60 // 60 mins to allow for overrunning event
    let paddedEventPeriod = DateInterval(
      start: eventPeriod.start - startPadding,
      end: eventPeriod.end + endPadding
    )

    if paddedEventPeriod.contains(currentDate) {
      return liveLink
    } else {
      return eventLink
    }
  }

  var node: Node {
    return El.A[Attr.href => currentLink, Attr.className => "EventFeature \(textShade.styleClass)"].containing(
      hero,
      dateBlock
    )
  }
}
