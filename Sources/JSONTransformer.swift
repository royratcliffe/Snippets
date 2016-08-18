// Snippets JSONTransformer.swift
//
// Copyright © 2016, Roy Ratcliffe, Pioneering Software, United Kingdom
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

/// Value transformer using JSON. Forward transforms from any object to data,
/// where any object includes dictionaries, arrays, strings, integers, floats,
/// booleans and nulls.
///
/// Pretty-prints the JSON by default. Allows solo JSON primitives by
/// default. Adjust the reading and writing options if defaults require an
/// alternative configuration.
public class JSONTransformer: ValueTransformer {

  public var readingOptions: JSONSerialization.ReadingOptions = .allowFragments
  public var writingOptions: JSONSerialization.WritingOptions = .prettyPrinted

  public override class func allowsReverseTransformation() -> Bool {
    return true
  }

  public override class func transformedValueClass() -> AnyClass {
    // swiftlint:disable:next force_cast
    return Data.self as! AnyClass
  }

  public override func transformedValue(_ value: Any?) -> Any? {
    guard let value = value else {
      return nil
    }
    return try? JSONSerialization.data(withJSONObject: value, options: writingOptions)
  }

  public override func reverseTransformedValue(_ value: Any?) -> Any? {
    guard let value = value as? Data else {
      return nil
    }
    return try? JSONSerialization.jsonObject(with: value, options: readingOptions)
  }

  /// Initialises the class before it receives its first message. Use the
  /// identity operator on the class and the receiver in order to avoid multiple
  /// initialisations when sub-classes exist.
  public override class func initialize() {
    guard self === JSONTransformer.self else { return }
    setValueTransformer(JSONTransformer(), forName: NSValueTransformerName(rawValue: NSStringFromClass(self)))
  }

}
