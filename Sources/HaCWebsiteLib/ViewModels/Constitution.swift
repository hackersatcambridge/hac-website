import HaCTML
import Foundation

struct Constitution {
  let mdText : String
  var node: Node {
    return UI.Pages.base(
      title: "Hackers at Cambridge",
      content: Fragment(
        El.Div[Attr.className => "Constitution"].containing(
          TextNode(Text(markdown: mdText).html, escapeLevel: .unsafeRaw)
        )
      )
    )
  }
}