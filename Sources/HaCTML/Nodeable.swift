/*
  Something that can be converted to a Node
 */
public protocol Nodeable {
  var node: Node { get } 
}

public extension Nodeable {
  func containedBy(element: HTMLElement) -> Node {
    return element.containing(self)
  }
}

extension String: Nodeable {
  public var node: Node {
    return TextNode(self)
  }
}
