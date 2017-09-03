/**
  A collection of attributes for a single HTML element
 */
struct AttributeMap: ExpressibleByArrayLiteral {
  typealias Element = Attribute

  // TODO: Make the key for this AttributeKey, so we can have multiple AttributeKeys with the same name
  private let attributeMap: Dictionary<String, Attribute>

  init(attributes arrayLiteral: [Element]) {
    var newAttributes = Dictionary<String, Attribute>()

    for attribute in arrayLiteral {
      newAttributes[attribute.key.keyName] = attribute
    }

    attributeMap = newAttributes
  }
  
  init (arrayLiteral: Element...) {
    self.init(attributes: arrayLiteral)
  }

  func get<Value>(key: AttributeKey<Value>) -> Value? {
    // TODO: Implement this as a subscript once we move to Swift 4
    //   It can't be one now as generic subscripts aren't allowed prior to Swift 4,
    //   and this function is generic
    return attributeMap[key.keyName]?.value as! Value?
  }

  func merge(attributes: [Attribute]) -> AttributeMap {
    return AttributeMap(attributes: attributeMap.values + attributes)
  }
  
  var renderedValues: [AppliedAttribute] {
    return attributeMap.values.map { attribute in attribute.key.apply(attribute.value) }
  }
  
  var isEmpty: Bool {
    return self.attributeMap.isEmpty
  }
}
