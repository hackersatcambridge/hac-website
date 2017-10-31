import HaCTML
import Foundation

struct ImageHero: Nodeable {
  let background: BackgroundType
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

  enum BackgroundType {
    case image(String)
    case color(String)

    var style: [String: String] {
      switch (self) {
      case .image(let path):
        return ["background-image": "url('\(path)')"]
      case .color(let color):
        return ["background-color": color]
      }
    }
  }
}
