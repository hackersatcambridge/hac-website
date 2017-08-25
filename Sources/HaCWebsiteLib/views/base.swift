import HaCTML

private let defaultTitle = "Cambridge's student tech society | Hackers at Cambridge"

private func stylesheet(forUrl: String) -> Node {
  return E.Link[A.rel => "stylesheet", A.type => "text/css", A.href => forUrl]
}

extension UI.Pages {
  static func base(title: String = defaultTitle, content: Node) -> Node {
    return Fragment(
      E.Doctype,
      E.Html[A.lang => "en"].c(
        E.Head.c(
          E.Meta[A.charset => "UTF-8"],
          E.Title.c(TextNode(title)),
          stylesheet(forUrl: "/static/styles/main.css"),
          stylesheet(forUrl: "https://fonts.googleapis.com/css?family=Cousine")
        ),
        E.Body.c(content)
      )
    )
  }
}
