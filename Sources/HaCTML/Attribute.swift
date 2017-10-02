enum AttributeValue {
  /**
    Represents a typical `key="value"` attribute where the value is the contained `String`
   */
  case text(String)

  /**
    Represents an attribute without a value, such as the `disabled` attribute when turned on.
    
    So `Attr.disabled => true` becomes `.noValue` and then renders as `<element disabled>`.
   */
  case noValue

  /**
    Represents an attribute that is not output at all, such as the `disabled` attribute when turned off.

    So `Attr.disabled => false` becomes `.removeAttribute` and then renders as `<element>`.
   */
  case removeAttribute
}

typealias AppliedAttribute = (keyName: String, value: AttributeValue)

/**
  Describes a possible key for an attribute of an HTML element and how it might be rendered.
 */
public struct AttributeKey<Value> {
  let keyName: String
  let applyFunc: (Value) -> AttributeValue

  internal init(_ key: String, apply: @escaping (Value) -> AttributeValue) {
    self.keyName = key
    self.applyFunc = apply
  }

  internal func apply(_ value: Value) -> AppliedAttribute {
    return (keyName: keyName, value: applyFunc(value))
  }

  fileprivate var asAny: AttributeKey<Any> {
    // swiftlint:disable:next force_cast
    return AttributeKey<Any>(keyName, apply: { self.applyFunc($0 as! Value) })
  }
}

/**
  A concrete realisation of an AttributeKey to an assigned value.

  These can only be created by applying the => operator to an AttributeKey.
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
