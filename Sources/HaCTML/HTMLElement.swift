public struct HTMLElement {
  let child: Node?
  let attributes: AttributeMap
  let tagName: String
  let selfClosing: Bool

  fileprivate init(tagName: String, attributes: AttributeMap = [], child: Node? = nil, selfClosing: Bool = false) {
    precondition(!selfClosing || child == nil, "\(tagName) cannot have children")

    self.child = child
    self.attributes = attributes
    self.tagName = tagName
    self.selfClosing = selfClosing
  }

  init(_ tagName: String, selfClosing: Bool = false) {
    self.init(tagName: tagName, selfClosing: selfClosing)
  }
  
  private func clone(attributes: AttributeMap? = nil, child: Node? = nil) -> HTMLElement {
    return HTMLElement(
      tagName: self.tagName,
      attributes: attributes ?? self.attributes,
      child: child ?? self.child, 
      selfClosing: self.selfClosing
    )
  }
  
  private func addChildren(nodes: [Node]) -> HTMLElement {
    precondition(child == nil, "Cannot add children to an element that already has children")

    return clone(child: nodes.count == 1 ? nodes[0] : Fragment(nodes))
  }
  
  /**
    Returns an HTMLElement identical to this one, with the given Nodes children
   */
  public func containing(_ nodes: Node...) -> HTMLElement {
    return addChildren(nodes: nodes)
  }
  
  /**
    Returns an HTMLElement identical to this one, with the given Nodes as children
   */
  public func containing(_ nodes: [Node]) -> HTMLElement {
    return addChildren(nodes: nodes)
  }

  /**
    Returns an HTMLElement identical to this one, with the given text as its only child
   */
  public func containing(_ text: String) -> HTMLElement {
    return addChildren(nodes: [TextNode(text)])
  }

  /**
    Returns an HTMLElement identical to this one, with the given attribute set
    merged into the current elements attribute set
   */
  public subscript(_ attributes: Attribute...) -> HTMLElement {
    return clone(attributes: self.attributes.merge(attributes: attributes))
  }
}
