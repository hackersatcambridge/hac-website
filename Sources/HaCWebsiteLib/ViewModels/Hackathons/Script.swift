import HaCTML

/**
 * This class is used in order load front-end scripts from a file relative to the current path for browsing pleasure.
 *
 * It depends on the build system loading files into the 'Data' folder before running.
 */
struct Script : Nodeable {
  let file : String
  let escapes : [String: String]
  var node: Node {
    return El.Script.containing(TextNode("Some JavaScript", escapeLevel: .unsafeRaw))
  }
}
