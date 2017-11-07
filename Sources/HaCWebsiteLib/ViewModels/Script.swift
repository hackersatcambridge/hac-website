import HaCTML
import DotEnv
import Foundation

protocol JavaScriptable {
  var javaScript: String {get}
}

extension String: JavaScriptable {
  var javaScript : String {
    // TODO: PROPERLY ESCAPE THIS! (eg. conver newlines to backslash)
    // NOTE: A JSON LIBRARY COULD BE USED FOR THIS!
    return "\"\(self)\""
  }
}

extension Date: JavaScriptable {
  var javaScript : String {
    let calendar = Calendar.current
    let year = calendar.component(.year, from: self)
    // We have to subtract 1 from the month as JavaScript months count from 0
    // See https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date
    let month = calendar.component(.month, from: self) - 1
    let day = calendar.component(.day, from: self)
    let hour = calendar.component(.hour, from: self)
    let minute = calendar.component(.minute, from: self)
    let second = calendar.component(.second, from: self)
    let milliseconds = 0
    return "new Date(Date.UTC(\(year),\(month),\(day),\(hour),\(minute),\(second),\(milliseconds)))"
  }
}

struct UnsafeRawJavaScript {
   let rawScript : String
   var javaScript : String {
     return rawScript
   }
}

/**
 * This class is used in order load front-end scripts from a file relative to the current path for browsing pleasure.
 *
 * It depends on the build system loading files into the 'Data' folder before running.
 */
struct Script : Nodeable {
  let file : String
  let escapes : [String: JavaScriptable]
  let directory : String = DotEnv.get("BACKEND_JS_DIR")!
  var node: Node {
    let pathToFile = directory + "/" + file
    do {
      var script = try String(contentsOfFile: pathToFile, encoding: .utf8)
      escapes.map({ (key, value) in
        // TODO: find out if there is a way of doing these escapes in a Type-Safe manner!
        script = script.replacingOccurrences(of: "{{\(key)}}", with: "\(value.javaScript)")
      })
      return El.Script.containing(TextNode(script, escapeLevel: .unsafeRaw))
    } catch {
      return El.Script.containing(TextNode("console.log(\"failed to load \(pathToFile)\");", escapeLevel: .unsafeRaw))
    }
  }
}
