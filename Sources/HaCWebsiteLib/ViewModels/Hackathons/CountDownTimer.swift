import HaCTML
import Foundation

/*
A count down timer for an event alongside a count down message.

The two necessary things for this are a startDate and and endDate. You can also
set custom messages. They will show different things based on whether the timer
is counting-down to the start of the event, to the end of the event, or if the
event is over.
*/
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
      El.Div[Attr.className => "CountDownTimer"].containing(
        El.Div[
          Attr.className => "CountDownTimer__pre",
          Attr.id => preId
        ].containing(""),
        El.Div[
          Attr.className => "CountDownTimer_time",
          Attr.id => id
        ].containing("YOU SHOULD SEE THE TIME REMAINING HERE"),
        Script(
          file: "Hackathons/CountDownTimer.js",
          definitions: [
            "startDate": startDate, "endDate": endDate,
            "id": id, "preId": preId,
            "beforeEventMessage": beforeEventMessage,
            "duringEventMessage": duringEventMessage,
            "afterEventMessage" : afterEventMessage
          ]
        )
      )
    )
  }
}
