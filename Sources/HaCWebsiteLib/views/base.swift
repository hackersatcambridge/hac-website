import HaCTML

private let defaultTitle = "Cambridge's student tech society | Hackers at Cambridge"

private func stylesheet(forUrl urlString: String) -> Node {
  return El.Link[Attr.rel => "stylesheet", Attr.type => "text/css", Attr.href => urlString]
}

extension UI.Pages {
  static func base(title: String = defaultTitle, content: Node) -> Node {
    return Fragment(
      El.Doctype,
      El.Html[Attr.lang => "en"].containing(
        El.Head.containing(
          El.Meta[Attr.charset => "UTF-8"],
          El.Meta[Attr.name => "viewport", Attr.content => "width=device-width, initial-scale=1"],
          El.Link[Attr.rel => "icon", Attr.type => "favicon/png", Attr.href => "/static/images/favicon.png"],
	  El.Title.containing(TextNode(title)),
          stylesheet(forUrl: "/static/styles/main.css")
        ),
        El.Body.containing(content)
      )
    )
  }
}
