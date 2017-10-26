import Foundation

enum Dates {
  private static let locale = Locale(identifier: "en_GB")

  static let individualDayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    formatter.locale = locale

    return formatter
  }()
}
