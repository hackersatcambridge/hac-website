import HTMLString

public func renderHTML(node: Node) -> String {
  return node.render()
}

extension TextNode: Node {
  public func render() -> String {
    switch (escapeLevel) {
    case .preserveViewedCharacters:
      return text.addingUnicodeEntities
    case .unsafeRaw:
      return text
    }
  }
}

extension Fragment: Node {
  public func render() -> String {
    return self.nodes.map({ $0.render() }).joined()
  }
}

extension HTMLElement: Node {
  public func render() -> String {
    if (self.tagName == "DOCTYPE") {
      return "<!DOCTYPE html>"
    }
    
    let attributeString = renderAttributeMap(self.attributes).map({ " " + $0 }) ?? ""
    let elementBody = self.tagName + attributeString
    
    if (self.selfClosing) {
      if (self.child != nil) {
        print("Not rendering children of self closing element \(self.tagName)")
      }
      
      return "<\(elementBody) />"
    }
    
    return "<\(elementBody)>\(self.child.map(renderHTML) ?? "")</\(self.tagName)>"
  }
}

func renderAttributeMap(_ attributes: AttributeMap) -> String? {
  guard !attributes.isEmpty else {
    return nil
  }
  
  return attributes.renderedValues.flatMap(renderAttribute).joined(separator: " ")
}

func renderAttribute(_ attribute: AppliedAttribute) -> String? {
  let (key, value) = attribute
  
  switch (value) {
  case .noValue:
    return key
  case .text(let text):
    return "\(key)=\"\(text.addingUnicodeEntities)\""
  case .removeAttribute:
    return nil
  }
}
