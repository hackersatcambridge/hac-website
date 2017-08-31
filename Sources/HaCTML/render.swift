import HTMLString

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
    
    return "<\(elementBody)>\(self.child.map({ $0.render() }) ?? "")</\(self.tagName)>"
  }
}

func renderAttributeMap(_ attributes: AttributeMap) -> String? {
  guard !attributes.isEmpty else {
    return nil
  }
  
  return attributes.renderedValues.flatMap(renderAttribute).joined(separator: " ")
}

func renderAttribute(_ attribute: AppliedAttribute) -> String? {
  switch (attribute.value) {
  case .noValue:
    return attribute.keyName
  case .text(let text):
    return "\(attribute.keyName)=\"\(text.addingUnicodeEntities)\""
  case .removeAttribute:
    return nil
  }
}
