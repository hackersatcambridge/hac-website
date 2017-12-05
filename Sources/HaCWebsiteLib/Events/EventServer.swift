import Foundation

public struct EventServer {
  //TODO: Rename this to getAllEvents
  static func getEvents() -> [GeneralEvent] {
    let events = try? GeneralEvent.makeQuery().filter("title", .notEquals, nil).all()
    guard let notNilEvents = events else {
      return []
    }
    return notNilEvents
  }
}