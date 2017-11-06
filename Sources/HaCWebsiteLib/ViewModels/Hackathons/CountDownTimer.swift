import HaCTML
import Foundation

struct CountDownTimer : Nodeable {
  let startDate : Date
  let endDate : Date
  let id = "CountDownTimer\(UUID().description)"

  let preId = "CountDownTimerPre\(UUID().description)" // the id of the countdown message
  let beforeEventMessage = "Time left to start"
  let duringEventMessage = "Time remaining"
  let afterEventMessage = "Time's up!"

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
        escapes: [
          "startDate": startDate, "endDate": endDate,
          "id": id, "preId": preId,
          "beforeEventMessage": beforeEventMessage,
          "duringEventMessage": duringEventMessage,
          "afterEventMessage" : afterEventMessage
        ]
      )
    )
  }
}
