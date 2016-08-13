// Snippets NSData+Snippets.swift
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

extension Data {

  /// Converts the data object to a hexadecimal string. Each byte from the data
  /// becomes two hexadecimal digits in the resulting character string. That
  /// makes the length of the string twice as long as the data. The string
  /// contains lower-case hexadecimal digits for 10 through 15, i.e. `a` through
  /// `f`. Use uppercaseString on the answer to convert to upper case.
  ///
  /// The `bytes` getter answers an unsafe pointer to `Void`. Cast this to an
  /// unsafe C pointer; a pointer to unsigned 8-bit integers. On its own, format
  /// specifier `%x` formats a 32-bit unsigned integer. Length modifier `hh`
  /// adjusts this to an 8-bit `char`. No need to worry too much about
  /// sign-extension or formatting precision. The `hh` modifier will limit the
  /// number of resulting characters to two, and no more than two, per byte.
  public var hexString: String {
    var hexString = ""
    let bytes = UnsafePointer<UInt8>((self as NSData).bytes)
    for index in 0 ..< count {
      hexString += String(format: "%02hhx", arguments: [bytes[index]])
    }
    return hexString
  }

}
