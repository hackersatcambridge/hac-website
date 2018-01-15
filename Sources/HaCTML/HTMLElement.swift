import HTMLString

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

  private func addChildren(nodeables: [Nodeable?]) -> HTMLElement {
    precondition(child == nil, "Cannot add children to an element that already has children")

    return clone(child: Fragment(nodeables))
  }

  /**
    Returns an HTMLElement identical to this one, with the given Nodes children
   */
  public func containing(_ nodeables: Nodeable?...) -> HTMLElement {
    return addChildren(nodeables: nodeables)
  }

  /**
    Returns an HTMLElement identical to this one, with the given Nodes as children
   */
  public func containing(_ nodeables: [Nodeable?]) -> HTMLElement {
    return addChildren(nodeables: nodeables)
  }

  /**
    Returns an HTMLElement identical to this one, with the given attribute set
    merged into the current elements attribute set
   */
  public subscript(_ attributes: Attribute...) -> HTMLElement {
    return clone(attributes: self.attributes.merge(attributes: attributes))
  }
}

extension HTMLElement: Node {
  public func render() -> String {
    if self.tagName == "DOCTYPE" {
      return "<!DOCTYPE html>"
    }

    let attributeString = self.attributes.rendered.map({ " " + $0 }) ?? ""
    let elementBody = self.tagName + attributeString

    if self.selfClosing {
      if self.child != nil {
        print("Not rendering children of self closing element \(self.tagName)")
      }

      return "<\(elementBody) />"
    }

    return "<\(elementBody)>\(self.child.map({ $0.render() }) ?? "")</\(self.tagName)>"
  }
}
