import Foundation

public struct EventServer {

  static func getAllEvents() -> [GeneralEvent] {
    let newEvents = try? GeneralEvent.makeQuery().all()
    return newEvents ?? []
  }

  static func getCurrentEvents() -> [GeneralEvent] {
    let currentDate = Date()
    let newEvents = try? GeneralEvent.makeQuery()
      .filter("hypeStartDate", .lessThanOrEquals, currentDate)
      .filter("hypeEndDate", .greaterThanOrEquals, currentDate)
      .all()
    return newEvents ?? []
  }
}