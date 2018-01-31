import HaCTML
import Foundation

// TODO: add the ability to highlight the item in the schedule best on the time!
struct Schedule : Nodeable {
  let schedule: [(String, Date)]

  var node: Node {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    formatter.timeZone = TimeZone(identifier: "Europe/London")
    formatter.locale = Locale(identifier: "en_GB")
    return El.Ul.containing(
      schedule.map {event, date in
      let timeString = formatter.string(from: date)
        return El.Li.containing(
          timeString,
          " ",
          event
        )
      }
    )
  }
}
