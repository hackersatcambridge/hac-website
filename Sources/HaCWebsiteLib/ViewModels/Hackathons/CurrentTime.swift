import HaCTML
import Foundation

struct CurrentTime : Nodeable {
  let id = "CurrentTime\(UUID().description)"

  var node: Node {
    return Fragment(
      El.Span[Attr.id => id, Attr.className => "CurrentTime"].containing("Current Time"),
      Script(
        file: "Hackathons/CurrentTime.js",
        definitions: ["id": id]
      )
    )
  }
}
