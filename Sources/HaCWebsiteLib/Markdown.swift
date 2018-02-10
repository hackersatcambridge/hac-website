import KituraMarkdown
import HaCTML

/// A type for text in Markdown form
struct Markdown {
  let raw: String

  init(_ markdown: String) {
    raw = markdown
  }

  public enum Error: Swift.Error {
    case initialisation(String)
  }

  init(contentsOfFile filePath: String) throws {
    do {
      self.init(try String(contentsOfFile: filePath, encoding: .utf8))
    } catch {
      throw Error.initialisation("Couldn't find (UTF8-encoded) file at \(filePath)")
    }
  }

  var html: String {
    return KituraMarkdown.render(from: raw)
  }
}

/// Allow use of Markdown as a TextNode
extension Markdown: Nodeable {
  var node: Node {
    return TextNode(
      html,
      escapeLevel: .unsafeRaw
    )
  }
}
