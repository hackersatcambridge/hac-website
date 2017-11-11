import KituraMarkdown
import HaCTML

/// A type for text in Markdown form
struct Markdown {
  let raw: String

  init(_ markdown: String) {
    raw = markdown
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