import HaCTML

struct ImageHero {
  let backgroundColor: String
  let imagePath: String
  let alternateText: String

  var node: Node {
    return El.Div[Attr.className => "ImageHero", Attr.style => ["background-color": backgroundColor]].containing(
      El.Div[Attr.className => "ImageHero__image", Attr.style => ["background-image": "url('\(imagePath)')"]],
      El.Div[Attr.className => "Text--screenReader"].containing(alternateText)
    )
  }
}