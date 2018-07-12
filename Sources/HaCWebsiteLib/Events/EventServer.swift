import Foundation

public struct EventServer {

  static func getAllEvents() -> [GeneralEvent] {
    let newEvents = try? GeneralEvent.makeQuery().all()
    return newEvents ?? []
  }

  static func getCurrentlyHypedEvents() -> [GeneralEvent] {
    let currentDate = Date()
    let newEvents = try? GeneralEvent.makeQuery()
      .filter("hypeStartDate", .lessThanOrEquals, currentDate)
      .filter("hypeEndDate", .greaterThanOrEquals, currentDate)
      .all()
    return newEvents ?? []
  }

  static func getEvents(from fromDate: Date, to toDate: Date) -> [GeneralEvent] {
    let newEvents = try? GeneralEvent.makeQuery()
      .filter("hypeStartDate", .lessThanOrEquals, toDate)
      .filter("hypeEndDate", .greaterThanOrEquals, fromDate)
      .all()
    return newEvents ?? []
  }

  static func getEvent(eventId: String) -> GeneralEvent? {
    do {
      let event = try GeneralEvent.makeQuery()
        .filter("eventId", .equals, eventId)
        .first()
      return event
    } catch {
      return nil
    }
  }
}