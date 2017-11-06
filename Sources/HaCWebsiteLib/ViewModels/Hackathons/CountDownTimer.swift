import HaCTML
import Foundation

struct CountDownTimer : Nodeable {
  let id = "CountDownTimer\(UUID().description)"
  let preId = "CountDownTimerPre\(UUID().description)"
  let startDate : Date
  let endDate : Date
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
