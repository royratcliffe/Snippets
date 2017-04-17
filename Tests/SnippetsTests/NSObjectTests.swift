// SnippetsTests NSObjectTests.swift
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

import XCTest

class NSObjectTests: SnippetsTests {

  func testAssociateNumber() {
    // given
    let object = NSObject()

    // when
    object.copyAssociated(object: 123, forKey: "number")

    // then
    XCTAssertEqual(object.associatedObject(forKey: "number") as? Int, 123)
  }

  /// Question is: Should `nil` be assigned or copied? Both work in exactly the
  /// same way. So likely the policy does not matter when the associated value
  /// is `nil`.
  func testDisassociateNumber() {
    // given
    let object = NSObject()
    XCTAssertNil(object.associatedObject(forKey: "number"))

    // when
    object.copyAssociated(object: 123, forKey: "number")
    XCTAssertEqual(object.associatedObject(forKey: "number") as? Int, 123)
    object.copyAssociated(object: nil, forKey: "number")

    // then
    XCTAssertNil(object.associatedObject(forKey: "number"))
  }

}
