import HaCTML
import Foundation

struct CurrentTime : Nodeable {
  let id = "CurrentTime\(UUID().description)"

  var node: Node {
    return Fragment(
      El.Span[Attr.id => id, Attr.className => "CurrentTime"].containing("Current Time"),
      // TODO: get this script to be loaded from CurrentTime.js
      //Script(file: "CurrentTime.js", escapes: ["className": CurrentTime.className]).node
      El.Script.containing(TextNode(
        "function updateClock() { const current = new Date(); document.getElementById(\"\(id)\").innerHTML = current.getHours()+\":\"+ (current.getMinutes()<10?\"0\":\"\") + current.getMinutes(); } updateClock(); setInterval(updateClock,1000);",
        escapeLevel: .unsafeRaw
      ))
    )
  }
}
