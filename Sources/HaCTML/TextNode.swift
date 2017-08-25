/**
  Some text in an HTML tree.
*/
public struct TextNode {
  let text: String
  let escapeLevel: EscapeLevel
  
  /**
    - parameters:
      - _: the text to display
      - escapeLevel: How much of the text to escape.
   */
  public init(_ text: String, escapeLevel: EscapeLevel = .all) {
    self.text = text
    self.escapeLevel = escapeLevel
  }

  /**
    Enumerates how we can esape text in an HTML tree
   */
  public enum EscapeLevel {
    // TODO: Come up with a solution for text in script/style tags as they are a special case for escaping.
    /**
      Escape everything that would otherwise render weirdly as text (e.g. < or &)
     */
    case all
    /**
      Display the text as-is. This could make the tree invalid HTML, so use at your own peril.
     */
    case dangerouslyRaw
  }
}
