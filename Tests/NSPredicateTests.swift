// SnippetsTests NSPredicateTests.swift
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
import Snippets

class NSPredicateTests: XCTestCase {

  func testAllSubpredicates() {
    // given
    let predicate = NSPredicate(format: "lhs = %@ AND rhs = %@", "left", "right")

    // when
    let subpredicates = predicate.allSubpredicates

    // then
    XCTAssertEqual(subpredicates.count, 2)
  }

  /// Extracts all the constant strings from the comparison predicates. Examines
  /// left and right expressions, looking for constant values. There should be
  /// two strings matching the predicate-argument strings; one left, one right.
  func testAllConstantValues() {
    // given
    let predicate = NSPredicate(format: "%@ = lhs OR rhs = %@", "left", "right")

    // when
    let constantStrings = predicate.allConstantValues.flatMap { $0 as? String }

    // then
    XCTAssertEqual(constantStrings.count, 2)
    XCTAssertTrue(constantStrings.contains("left"))
    XCTAssertTrue(constantStrings.contains("right"))
  }

}
