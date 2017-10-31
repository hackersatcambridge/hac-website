import Foundation

enum DateUtils {
  private static let locale = Locale(identifier: "en_GB")

  static let individualDayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    formatter.locale = locale

    return formatter
  }()
}

extension Date {
  static func from(year: Int, month: Int, day: Int, hour: Int, minute: Int, timezone: TimeZone? = nil) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    formatter.timeZone = timezone ?? TimeZone(identifier: "Europe/London")
    if let result = formatter.date(from: "\(year)-\(month)-\(day) \(hour):\(minute)") {
      return result
    } else {
      fatalError("Improper date given: \(year)-\(month)-\(day) \(hour):\(minute) does not exist")
    }
  }
}
