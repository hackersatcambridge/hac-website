/**
  Anything in an HTML tree
 */
public protocol Node {
  // This is very intentionally not an enum.
  //
  // Firstly, having something be simultaneously a Node and a concrete
  // implementation of one is very useful.
  //
  // Secondly, this potentially opens us up to extension by other things implementing this.
  // We should tread that territory carefully.

  /**
   * Turn this node into an HTML string
   */
  func render() -> String
}
