import HaCTML

// TODO: add the ability to highlight the item in the schedule best on the time!
struct Schedule : Nodeable {
  let schedule: [String: String]

  var node: Node {
    return El.Ul.containing(
      schedule.map {
        El.Li.containing(
          $0.key,
          " ",
          $0.value
        )
      }
    )
  }
}
