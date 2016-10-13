// Snippets Configuration.swift
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

/// Configures objects by retaining a dictionary of keyed value-blocks and
/// evaluating those blocks if the objects to configure respond to the
/// corresponding setter selectors.
///
/// The `Configuration` object exists as an `NSObject` because it can belong to
/// its own configuration. Avoid retain cycles by making such self-references
/// weak.
public class Configuration: NSObject {

  /// Value blocks are captures that answer an optional object.
  public typealias ValueBlock = () -> Any?

  var keyedValueBlocks = [String: ValueBlock]()

  /// Adds a new value block for the given key. Replaces an existing value block
  /// if the key already exists.
  public func add(forKey key: String, valueBlock: @escaping ValueBlock) {
    keyedValueBlocks[key] = valueBlock
  }

  /// Configures the given object. Results in a sequence of zero or more
  /// key-value coding (KVC) set-value or set-nil-value calls for zero or more
  /// setter-responding keys.
  /// - parameter object: KVC-compliant object to receive new values.
  /// - returns: Total number of non-nil values transferred to the object.
  public func configure(object: NSObject) -> Int {
    return object.setValues(forKeys: keyedValueBlocks)
  }

  /// Evaluates the value block for the given key.
  /// - parameter key: Key to evaluate.
  /// - returns: Result of evaluating block; `nil` if no block.
  public func value(of key: String) -> Any? {
    return keyedValueBlocks[key]?()
  }

}
