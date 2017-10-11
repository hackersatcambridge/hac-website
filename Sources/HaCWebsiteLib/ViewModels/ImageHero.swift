import HaCTML

struct ImageHero {
  let background: BackgroundType
  let imagePath: String
  let alternateText: String
  let destinationURL: String?

  var node: Node {
    return blockElement[Attr.style => backgroundStyle].containing(
      El.Div[Attr.className => "ImageHero__image", Attr.style => ["background-image": "url('\(imagePath)')"]],
      El.Div[Attr.className => "Text--screenReader"].containing(alternateText)
    )
  }

  enum BackgroundType {
    case image(String)
    case color(String)
  }

  private var blockElement: HTMLElement {
    if let destinationURL = self.destinationURL {
      return El.A[Attr.className => "ImageHero ImageHero--linkable", Attr.href => destinationURL, Attr.target => "_blank"]
    }

    return El.Div[Attr.className => "ImageHero"]
  }

  private var backgroundStyle: [String: String] {
    switch (background) {
    case .image(let path):
      return ["background-image": "url('\(path)')"]
    case .color(let color):
      return ["background-color": color]
    }
  }
}