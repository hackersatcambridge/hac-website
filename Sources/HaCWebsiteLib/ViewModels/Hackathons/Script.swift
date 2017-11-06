import HaCTML
import DotEnv
import Foundation

protocol JavaScriptable {
  var javaScript: String {get}
}

extension String: JavaScriptable {
  var javaScript : String {
    // PROPERLY ESCAPE THIS! (eg. conver newlines to backslash)
    return "\"\(self)\""
  }
}

extension Date: JavaScriptable {
  var javaScript : String {
    let calendar = Calendar.current
    let year = calendar.component(.year, from: self)
    let month = calendar.component(.month, from: self)
    let day = calendar.component(.day, from: self)
    let hour = calendar.component(.hour, from: self)
    let minute = calendar.component(.minute, from: self)
    let second = calendar.component(.second, from: self)
    let milisecond = 0
    // TODO: work out how JavaScript dates work
    // TODO: handle timezones
    return "new Date(\(year),\(month)-1,\(day),\(hour),\(minute),\(second),\(milisecond))"
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
      escapes.map({ key, value in
        script = script.replacingOccurrences(of: "{{\(key)}}", with: "\(value.javaScript)")
      })
      return El.Script.containing(TextNode(script, escapeLevel: .unsafeRaw))
    } catch {
      return El.Script.containing(TextNode("console.log(\"failed to load \(pathToFile)\");", escapeLevel: .unsafeRaw))
    }
  }
}
