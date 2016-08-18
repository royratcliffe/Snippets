// SnippetsTests JSONTransformerTests.swift
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

import XCTest

class JSONTransformerTests: XCTestCase {

  /// Tests transforming an array to JSON using the JSON transformer. The
  /// transformer pretty-prints the JSON so compare against pretty JSON
  /// output. White space makes it pretty.
  func testArray() {
    // given
    let transformer = ValueTransformer(forName: NSValueTransformerName("Snippets.JSONTransformer"))!
    // when
    // swiftlint:disable:next force_cast
    let data = transformer.transformedValue([1, 2, 3]) as! Data
    let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
    // then
    XCTAssertEqual(string, "[\n  1,\n  2,\n  3\n]")
  }

}
