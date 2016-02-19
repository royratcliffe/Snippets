// SnippetsTests SequenceTypeTests.swift
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

class SequenceTypeTests: XCTestCase {

  /// `Array(1...6).groupBy { $0 % 3 } == [0: [3, 6], 1: [1, 4], 2: [2, 5]]`
  func testGroupBy() {
    // given
    let elements = Array(1...6)
    // when
    let groups = elements.groupBy { (i) -> NSObject in
      i % 3
    }
    // then
    XCTAssertEqual(groups.count, 3)
    XCTAssertNotNil(groups[0])
    XCTAssertNotNil(groups[1])
    XCTAssertNotNil(groups[2])
    XCTAssertEqual(groups[0]!, [3, 6])
    XCTAssertEqual(groups[1]!, [1, 4])
    XCTAssertEqual(groups[2]!, [2, 5])
    XCTAssertEqual(groups, [0: [3, 6], 1: [1, 4], 2: [2, 5]])
  }

}
