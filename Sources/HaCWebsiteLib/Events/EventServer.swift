import Foundation

public struct EventServer {
  
  static func getAllEvents() -> [GeneralEvent] {
    let events = try? GeneralEvent.makeQuery().filter("title", .notEquals, nil).all()
    guard let notNilEvents = events else {
      return []
    }
    return notNilEvents
  }
}