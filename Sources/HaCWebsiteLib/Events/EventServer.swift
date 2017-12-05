import Foundation

public struct EventServer {

  private(set) static var events: [GeneralEvent] = []

  static func update() {
    let newEvents = try? GeneralEvent.makeQuery().filter("title", .notEquals, nil).all()
    guard let notNilEvents = newEvents else {
      events = []
      return
    }
    events = notNilEvents
  }

  static func getAllEvents() -> [GeneralEvent] {
    return events
  }

  static func getCurrentEvents() -> [GeneralEvent] {
    return events.filter{ event in 
      let currentDate = Date()
      return event.hypePeriod.contains(currentDate)
    }
  }
}