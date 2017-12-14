import HaCTML
import Foundation

struct Constitution: Nodeable {
  let mdText: String
  var node: Node {
    return Page(
      title: "Hackers at Cambridge",
      content: Fragment(
        El.Div[Attr.className => "Constitution"].containing(
          Markdown(mdText)
        )
      )
    ).node
  }
}