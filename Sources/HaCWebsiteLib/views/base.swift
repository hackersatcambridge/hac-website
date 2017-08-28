import HaCTML

private let defaultTitle = "Cambridge's student tech society | Hackers at Cambridge"

private func stylesheet(forUrl: String) -> Node {
  return El.Link[Attr.rel => "stylesheet", Attr.type => "text/css", Attr.href => forUrl]
}

extension UI.Pages {
  static func base(title: String = defaultTitle, content: Node) -> Node {
    return Fragment(
      El.Doctype,
      El.Html[Attr.lang => "en"].c(
        El.Head.c(
          El.Meta[Attr.charset => "UTF-8"],
          El.Title.c(TextNode(title)),
          stylesheet(forUrl: "/static/styles/main.css"),
          stylesheet(forUrl: "https://fonts.googleapis.com/css?family=Cousine")
        ),
        El.Body.c(content)
      )
    )
  }
}
