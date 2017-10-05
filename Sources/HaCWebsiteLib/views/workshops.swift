import HaCTML

/**
  Outputs a key-value pair if and only if 'value' is not nil
*/
private func OptionalFieldNode(key: String, value: String?, placeholder: String? = nil) -> Node {
  if let v = value {
    return El.P.containing(TextNode(key + ": "), TextNode(v))
  } else {
    return El.P.containing(TextNode(key + ": "), TextNode("TBD"))
    // return EmptyNode()
  }
}

private func thanksString(thanks: Workshop.Thanks) -> String {
  if let reason = thanks.reason {
    return "\(thanks.to) for \(reason)"
  }

  return thanks.to
}

private func workshop(_ workshop: Workshop) -> Node {
  return El.Div.containing(
    El.H2[Attr.className => "mono"].containing(workshop.title),
    El.H3.containing("Description"),
    TextNode(workshop.description.html, escapeLevel: .unsafeRaw),
    El.H3.containing("Prerequisites"),
    TextNode(workshop.prerequisites.html, escapeLevel: .unsafeRaw),
    El.H3.containing("Recommended Links"),
    El.Ul.containing(
      workshop.recommendations.map({
        El.Li.containing(
          El.A[Attr.href => $0.url.absoluteString].containing($0.title)
        )
      })
    ),
    OptionalFieldNode(key: "Date", value: workshop.date),
    OptionalFieldNode(key: "Time", value: workshop.time),
    OptionalFieldNode(key: "Location", value: workshop.location),
    El.P.containing("With thanks to"),
    El.Ul.containing(
      workshop.thanks.map({
        El.Li.containing(thanksString(thanks: $0))
      })
    ),
    El.P.containing(
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
