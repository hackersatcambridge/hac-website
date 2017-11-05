import HaCTML

struct CurrentTime : Nodeable {
  static let className = "RealTimeClock"
  static let element = El.Span[Attr.className => CurrentTime.className].containing("Current Time")
  static var ScriptUsed = false
  var node: Node {
    if(!CurrentTime.ScriptUsed) {
      CurrentTime.ScriptUsed = true
      return Fragment(
        CurrentTime.element,
        // TODO: get this script to be loaded from CurrentTime.js
        //Script(file: "CurrentTime.js", escapes: ["className": CurrentTime.className]).node
        El.Script.containing(TextNode(
          "function updateClock() { const current = new Date(); Array.from(document.getElementsByClassName(\"\(CurrentTime.className)\")).map(function(x) { x.innerHTML = current.getHours()+\":\"+ (current.getMinutes()<10?\"0\":\"\") + current.getMinutes(); });} updateClock(); setInterval(updateClock,1000);",
          escapeLevel: .unsafeRaw
        ))
      )
    } else {
      return CurrentTime.element
    }
  }
}
