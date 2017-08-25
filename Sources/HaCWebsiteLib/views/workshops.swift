import HaCTML

private func thanksString(thanks: Workshop.Thanks) -> String {
  if let reason = thanks.reason {
    return "\(thanks.to) for \(reason)"
  }

  return thanks.to
}

private func workshop(_ workshop: Workshop) -> Node {
  return E.Div.c(
    E.H2[A.className => "mono"].c(workshop.title),
    E.H3.c("Description"),
    TextNode(workshop.description.html, escapeLevel: .dangerouslyRaw),
    E.H3.c("Prerequisites"),
    TextNode(workshop.prerequisites.html, escapeLevel: .dangerouslyRaw),
    E.H3.c("Recommended Links"),
    E.Ul.c(
      workshop.recommendations.map({
        E.Li.c(
          E.A[A.href => $0.url.absoluteString].c($0.title)
        )
      })
    ),
    E.P.c("With thanks to"),
    E.Ul.c(
      workshop.thanks.map({
        E.Li.c(thanksString(thanks: $0))
      })
    ),
    E.P.c(
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
        E.Br,
        Fragment(workshops.map(workshop))
      )
    )
  }
}
