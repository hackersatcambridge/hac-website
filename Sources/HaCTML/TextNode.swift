/**
  Some text in an HTML tree.
*/
public struct TextNode {
  let text: String
  let escapeLevel: EscapeLevel
  
  /**
    - parameters:
      - text: the text to display
      - escapeLevel: How much of the text to escape.
   */
  public init(_ text: String, escapeLevel: EscapeLevel = .preserveViewedCharacters) {
    self.text = text
    self.escapeLevel = escapeLevel
  }

  /**
    Enumerates how we can esape text in an HTML tree
   */
  public enum EscapeLevel {
    // TODO: Come up with a solution for text in script/style tags as they are a special case for escaping.
    /**
      What you read in code is what you see as text in the rendered page. This means escaping everything that would otherwise
      render weirdly as text (e.g. < or &)
     */
    case preserveViewedCharacters
    /**
      Display the text as-is. This could make the tree invalid HTML, so use at your own peril.
     */
    case unsafeRaw
  }
}
