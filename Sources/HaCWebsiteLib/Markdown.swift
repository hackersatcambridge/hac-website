import KituraMarkdown
import HaCTML

/// A type for text in Markdown form
struct Markdown {
  var raw: String

  init(_ markdown: String) {
    raw = markdown
  }

  init(contentsOfFile filePath: String) throws {
    self.init(try String(contentsOfFile: filePath, encoding: .utf8))
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
