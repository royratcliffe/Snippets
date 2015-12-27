// SnippetsTests UIColorTests.swift
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

import XCTest

class UIColorTests: XCTestCase {

  func testHashABC() {
    // given
    let color = UIColor.fromHTML("#abc")

    // when
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    color?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    // then
    XCTAssertNotNil(color)
    XCTAssertEqual(red, 0xaa / 255.0)
    XCTAssertEqual(green, 0xbb / 255.0)
    XCTAssertEqual(blue, 0xcc / 255.0)
    XCTAssertEqual(alpha, 0xff / 255.0)
    XCTAssertEqual(color, UIColor.fromHTML("aabbcc"))
    XCTAssertEqual(color, UIColor.fromHTML("ffaabbcc"))
  }

}
