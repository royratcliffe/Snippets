// Snippets UIColor+Snippets.swift
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

extension UIColor {

  /// - returns: a UIColor based on a HTML colour string. Answers `nil` if the
  ///   given string cannot convert to a colour because there are not enough, or
  ///   too many, hexadecimal digits.
  ///
  /// Implementation uses a regular expression to extract all the hexadecimal
  /// digits, ignoring hash prefixes and whitespace if any. Aborts if the
  /// regular expression for a hexadecimal digit fails to compile, logging the
  /// expression compilation error to the system log.
  public class func from(html string: String) -> UIColor? {
    var expression: NSRegularExpression
    do {
      expression = try NSRegularExpression(pattern: "[0-9a-f]", options: .caseInsensitive)
    } catch {
      (error as NSError).log()
      abort()
    }
    let range = NSRange(location: 0, length: string.characters.count)
    let matches = expression.matches(in: string, options: [], range: range)
    let digits = matches.map { (match) -> String in
      (string as NSString).substring(with: match.range)
    }
    var digitPairs: [String]
    switch digits.count {
    case 3, 4:
      // rgb, argb
      digitPairs = digits.map { (digit) -> String in
        digit + digit
      }
    case 6, 8:
      // rrggbb, aarrggbb
      digitPairs = (0..<(digits.count >> 1)).map({ (index) -> String in
        digits[index << 1] + digits[(index << 1) + 1]
      })
    default:
      return nil
    }
    let components = digitPairs.map { (digitPair) -> CGFloat in
      var result: UInt32 = 0
      // Ignore the fact that the scanner can answer false. It never will
      // because we already know that the scanner will always see hexadecimal,
      // nothing more, nothing less.
      Scanner(string: digitPair).scanHexInt32(&result)
      return CGFloat(result) / 255.0
    }
    var floats = components.makeIterator()
    let alpha = components.count == 4 ? floats.next()! : 1.0
    let red = floats.next()!
    let green = floats.next()!
    let blue = floats.next()!
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }

}
