// Snippets NSError+Snippets.swift
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

extension NSError {

  /// Logs the error, sending its values to the console log, i.e. the Apple
  /// System Log facility. Uses Key-Value-Coding introspection to log all the
  /// primary error values; also logs the user-information dictionary entries if
  /// present. Does not send nils to the log. Only logs non-nil error values.
  ///
  /// The implementation pads out the error keys with spaces so that the values
  /// all start at the same column in the System Log, or debugger Console.
  public func log() {
    let keys = ["domain", "code", "localizedDescription", "localizedFailureReason", "localizedRecoverySuggestion"]
    var keysAndValues = keys.map { key in (key, valueForKey(key)) }.filter { (key, value) in value != nil }
    for (key, value) in userInfo {
      keysAndValues.append(("userInfo.\(key)", value))
    }
    let maxKeyLength = keysAndValues.map { (key, value) in key.characters.count }.maxElement() ?? 0
    for (key, value) in keysAndValues {
      if let value = value {
        let padding = "".stringByPaddingToLength(maxKeyLength - key.characters.count, withString: " ", startingAtIndex: 0)
        NSLog("ERROR %@%@:%@", padding, key, String(value))
      }
    }
  }

}
