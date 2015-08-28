// Snippets NSBundle+Snippets.swift
//
// Copyright © 2015, Roy Ratcliffe, Pioneering Software, United Kingdom
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

extension NSBundle {

  /// Loads an immutable property list from a named resource within a named
  /// sub-directory. Fails by answering `nil` if the resource does not exist, or
  /// it fails to load. Throws an error if the data loads but fails to decode as
  /// a properly-formatted property list.
  ///
  /// For some reason, `URLForResource` has an optional name parameter. Apple
  /// documentation does not make it clear what happens if the name is
  /// `nil`. This method does not follow the same pattern. The name string is
  /// *not* optional.
  public func propertyListForResource(name: String, subdirectory: String?) throws -> AnyObject? {
    guard let URL = URLForResource(name, withExtension: "plist", subdirectory: subdirectory) else {
      return nil
    }
    guard let data = NSData(contentsOfURL: URL) else {
      return nil
    }
    return try NSPropertyListSerialization.propertyListWithData(data, options: .Immutable, format: nil)
  }

}
