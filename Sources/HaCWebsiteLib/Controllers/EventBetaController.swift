import Kitura
import Foundation
import HaCTML

func getDate() -> Date {
  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy/MM/dd HH:mm"
  return formatter.date(from: "2017/12/13 14:31") ?? Date()
}

struct EventBetaController {
    static var handler: RouterHandler = { request, response, next in
    try response.send(
      EventFeature(
        eventPeriod: DateInterval(start: getDate(), duration: 120.0),
        eventLink: "http://google.com",
        liveLink: "http://google.com",
        hero: El.Div,
        textShade: .dark
      ).node.render()
    ).end()
  }
}
