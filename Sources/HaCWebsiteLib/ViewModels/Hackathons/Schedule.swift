import HaCTML

// TODO: add the ability to highlight the item in the schedule best on the time!
struct Schedule : Nodeable {
  let schedule: [(String, String)]

  var node: Node {
    return El.Ul.containing(
      schedule.map {key, value in
        El.Li.containing(
          key,
          " ",
          value
        )
      }
    )
  }
}
