// Snippets UIDevice+Snippets.swift
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

import UIKit

extension UIDevice {

  /// Converts non-integer version numbers to 0. So if you have an atypical
  /// version number with non-digit characters, then the resulting version
  /// number fails to parse as an integer and becomes zero in the resulting
  /// array of integers.
  /// - returns: Answers the system version number as an array of integers.
  public var systemVersionNumbers: [Int] {
    return systemVersion.components(separatedBy: ".").map { Int($0) ?? 0 }
  }

  /// - returns: Answers the first version number. Answers `nil` if there is no
  /// first version number.
  public var systemMajorVersion: Int? {
    let numbers = systemVersionNumbers
    return numbers.count >= 1 ? numbers[0] : nil
  }

  /// - returns: Answers the second version number.
  public var systemMinorVersion: Int? {
    let numbers = systemVersionNumbers
    return numbers.count >= 2 ? numbers[1] : nil
  }

  /// - returns: Answers the third version number.
  public var systemPatchVersion: Int? {
    let numbers = systemVersionNumbers
    return numbers.count >= 3 ? numbers[2] : nil
  }

}
