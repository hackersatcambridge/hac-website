import HaCTML
import Foundation

struct ImageHero: Nodeable {
  let background: Background
  let imagePath: String
  let alternateText: String

  var node: Node {
    return El.Div[
      Attr.className => "ImageHero",
      Attr.style => background.style
    ].containing(
      El.Div[Attr.className => "ImageHero__image", Attr.style => ["background-image": "url('\(imagePath)')"]],
      El.Div[Attr.className => "Text--screenReader"].containing(alternateText)
    )
  }
}
