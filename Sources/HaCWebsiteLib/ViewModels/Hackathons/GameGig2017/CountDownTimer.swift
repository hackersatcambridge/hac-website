import HaCTML

// TODO: add the ability to highlight the item in the schedule best on the time!
struct CountDownTimer : Nodeable {
  var node: Node {
    return El.Div[Attr.className => "CountDownTimer"].containing("Time's up! PLACEHOLDER")
  }
}