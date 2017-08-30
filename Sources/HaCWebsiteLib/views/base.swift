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
          El.Title.containing(TextNode(title)),
          stylesheet(forUrl: "/static/styles/main.css"),
          stylesheet(forUrl: "https://fonts.googleapis.com/css?family=Cousine")
        ),
        El.Body.containing(content)
      )
    )
  }
}
