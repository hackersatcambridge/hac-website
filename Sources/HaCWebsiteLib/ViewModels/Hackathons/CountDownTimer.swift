import HaCTML
import Foundation

struct CountDownTimer : Nodeable {
  let id = "CountDownTimer\(UUID().description)"
  let preId = "CountDownTimerPre\(UUID().description)"
  let startDate = Date.from(year: 2017, month: 12, day: 1, hour: 10, minute: 30)
  let endDate = Date.from(year: 2017, month: 12, day: 1, hour: 20, minute: 0)
  var node: Node {
    return Fragment(
      El.Div[
        Attr.className => "CountDownTimer__pre",
        Attr.id => preId
      ].containing(""),
      El.Div[
        Attr.className => "CountDownTimer",
        Attr.id => id
      ].containing("YOU SHOULD SEE THE TIME REMAINING HERE"),
      Script(
        file: "Hackathons/CountDownTimer.js",
        escapes: ["id": id, "preId": preId, "startDate": startDate, "endDate": endDate]
      )
    )
  }
}
