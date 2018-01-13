private func stringAttribute(_ key: String) -> AttributeKey<String> {
  return AttributeKey(key, apply: { .text($0) })
}

private func numberAttribute(_ key: String) -> AttributeKey<Int> {
  return AttributeKey(key, apply: { .text(String($0)) })
}

private func CSSAttribute(_ key: String) -> AttributeKey<[String: String?]> {
  return AttributeKey(key, apply: { dict in
    .text(
      // filter out the nil values
      dict.flatMap {
        $0 as? (String, String)
      }.map {
        "\($0): \($1);"
      }.joined(separator: " ")
    )
  })
}

public enum Attributes {
  // We are filling this list in incrementally,
  // implementing attributes as we need them so that we can type them correctly
  static public let alt = stringAttribute("alt")
  static public let charset = stringAttribute("charset")
  static public let className = stringAttribute("class")
  static public let content = stringAttribute("content")
  static public let height = numberAttribute("height")
  static public let href = stringAttribute("href")
  static public let id = stringAttribute("id")
  static public let lang = stringAttribute("lang")
  static public let name = stringAttribute("name")
  static public let rel = stringAttribute("rel")
  static public let src = stringAttribute("src")
  static public let srcset = stringAttribute("srcset")
  static public let style = CSSAttribute("style")
  static public let target = stringAttribute("target")
  static public let type = stringAttribute("type")
  static public let placeholder = stringAttribute("placeholder")
  static public let tabIndex = numberAttribute("tab-index")
  static public let width = numberAttribute("width")
}

// Creating a more concise namespace for expressivity
public let Attr = Attributes.self
