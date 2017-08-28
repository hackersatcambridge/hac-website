import HaCTML

private func thanksString(thanks: Workshop.Thanks) -> String {
  if let reason = thanks.reason {
    return "\(thanks.to) for \(reason)"
  }

  return thanks.to
}

private func workshop(_ workshop: Workshop) -> Node {
  return El.Div.c(
    El.H2[Attr.className => "mono"].c(workshop.title),
    El.H3.c("Description"),
    TextNode(workshop.description.html, escapeLevel: .dangerouslyRaw),
    El.H3.c("Prerequisites"),
    TextNode(workshop.prerequisites.html, escapeLevel: .dangerouslyRaw),
    El.H3.c("Recommended Links"),
    El.Ul.c(
      workshop.recommendations.map({
        El.Li.c(
          El.A[Attr.href => $0.url.absoluteString].c($0.title)
        )
      })
    ),
    El.P.c("With thanks to"),
    El.Ul.c(
      workshop.thanks.map({
        El.Li.c(thanksString(thanks: $0))
      })
    ),
    El.P.c(
      TextNode("Tags: "),
      TextNode(workshop.tags.joined(separator: ", "))
    )
  )
}

extension UI.Pages {
  static func workshops(workshops: [Workshop]) -> Node {
    return UI.Pages.base(
      title: "Workshops",
      content: Fragment(
        TextNode("There are \(workshops.count) workshops."),
        El.Br,
        Fragment(workshops.map(workshop))
      )
    )
  }
}
