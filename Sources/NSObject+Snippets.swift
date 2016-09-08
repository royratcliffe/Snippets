// Snippets NSObject+Snippets.swift
//
// Copyright © 2015, 2016, Roy Ratcliffe, Pioneering Software, United Kingdom
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS,” WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
//------------------------------------------------------------------------------

import Foundation

extension NSObject {

  public class var objCRuntimePropertyNames: [String] {
    var count: UInt32 = 0
    var propertyNames = [String]()
    let propertyList = class_copyPropertyList(self, &count)
    if propertyList != nil {
      for index in 0..<Int(count) {
        let name = property_getName(propertyList?[index])
        // swiftlint:disable:next force_cast
        propertyNames.append(NSString(utf8String: name!) as! String)
      }
      free(propertyList)
    }
    return propertyNames
  }

  public var objCRuntimePropertyNames: [String] {
    return type(of: self).objCRuntimePropertyNames
  }

  public var objCRuntimeProperties: [String: Any] {
    var properties = [String: Any]()
    for name in objCRuntimePropertyNames {
      if let value = value(forKey: name) {
        properties[name] = value
      }
    }
    return properties
  }

  /// Conditionally performs a given selector string using the given object as
  /// argument. The selector string should have a colon terminator, the only
  /// colon in the string.
  public func perform(_ selectorString: String, with object: Any) -> Any? {
    let selector = Selector(selectorString)
    guard responds(to: selector) else {
      return nil
    }
    return self.perform(selector, with: object).takeRetainedValue()
  }

  /// Sets up values for keys where the values originate from
  /// conditionally-called captures. Only calls the captures if this object has
  /// a corresponding setter method.
  ///
  /// Ignores keys which are invalid for this object. There is no key-value
  /// coding introspection method. The implementation cannot directly ask this
  /// class, or its sub-classes, which keys are valid and which are not
  /// valid. Simulates key-value introspection by synthesising the setter method
  /// selector.
  ///
  /// - parameter keyedValueBlocks: key-value coding names mapping to captures
  ///   answering some object if and when called. If this object has a key-value
  ///   coding property corresponding to the key, then ask the capture for some
  ///   object and send the object to `self` using key-value coding.
  /// - returns: number of values set. This includes only non-nil values, even
  ///   though nil values are transferred to the object as well. Useful for
  ///   knowing if the object responds to the value blocks or not. Answer zero
  ///   if no transfer of values at all.
  public func setValues(forKeys keyedValueBlocks: [String: () -> Any?]) -> Int {
    var result = 0
    for (key, valueBlock) in keyedValueBlocks {
      if responds(to: Selector(setter: key)) {
        if let value = valueBlock() {
          setValue(value, forKey: key)
          result += 1
        } else {
          setNilValueForKey(key)
        }
      }
    }
    return result
  }

}
