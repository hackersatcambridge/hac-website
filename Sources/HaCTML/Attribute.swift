enum AttributeValue {
  case text(String)
  case noValue
  case removeAttribute
}

typealias AppliedAttribute = (String, AttributeValue)

/**
 * Describes a possible key for an attribute of an HTML element and how it might be rendered
 */
public struct AttributeKey<Value> {
  let keyName: String
  let applyFunc: (Value) -> AttributeValue

  internal init(_ key: String, apply: @escaping (Value) -> AttributeValue) {
    self.keyName = key
    self.applyFunc = apply
  }
  
  internal func apply(_ value: Value) -> AppliedAttribute {
    return (keyName, applyFunc(value))
  }

  fileprivate var asAny: AttributeKey<Any> {
    return AttributeKey<Any>(keyName, apply: { self.applyFunc($0 as! Value) })
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
public func => <Value>(_ key: AttributeKey<Value>, _ value: Value) -> Attribute {
  return Attribute(key.asAny, value)
}
