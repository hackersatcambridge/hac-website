enum AttributeValue {
  case text(String)
  case flagOn
  case gone
}

typealias RenderedAttribute = (String, AttributeValue)

/**
 * Describes a possible key for an attribute of an HTML element and how it might be rendered
 */
public struct AttributeKey<Value> {
  let keyName: String
  let renderFunc: (Value) -> AttributeValue

  internal init(_ key: String, render: @escaping (Value) -> AttributeValue) {
    self.keyName = key
    self.renderFunc = render
  }
  
  internal func render(_ value: Value) -> RenderedAttribute {
    return (keyName, renderFunc(value))
  }

  fileprivate func asAny() -> AttributeKey<Any> {
    return AttributeKey<Any>(keyName, render: { self.renderFunc($0 as! Value) })
  }
}

/**
 * A concrete realisation of an AttributeKey to an assigned value
 *
 * These can only be created by applying the => operator to an AttributeKey
 */
public struct Attribute {
  let key: AttributeKey<Any>
  let value: Any

  fileprivate init(_ key: AttributeKey<Any>, _ value: Any) {
    self.value = value
    self.key = key
  }
}

infix operator =>
public func => <Value>(_ from: AttributeKey<Value>, _ to: Value) -> Attribute {
  return Attribute(from.asAny(), to)
}
