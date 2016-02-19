// SnippetsTests IndexSetTests.swift
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

class IndexSetTests: XCTestCase {

  /// See http://math.wikia.com/wiki/Symmetric_difference for details.
  func testSymmetricDifference() {
    // given
    let setA = NSIndexSet(indexes: [1, 3, 5, 7, 9])
    let setB = NSIndexSet(indexes: [1, 2, 3, 4, 5])
    // when
    let symmetricDifference = setA.symmetricDifference(setB)
    // then
    XCTAssertEqual(symmetricDifference, NSIndexSet(indexes: [2, 4, 7, 9]))
  }

  /// Note, you cannot compare NSRange equal, i.e. assert equal, because they
  /// are not `NSObject`s. NSRange is a `struct`. Instead, convert them to
  /// `NSString`s and compare the strings for equality.
  func testRanges() {
    // given
    let set = NSIndexSet(indexes: [1, 2, 4, 5])
    // when
    let ranges = set.ranges
    // then
    XCTAssertEqual(ranges.count, 2)
    XCTAssertEqual(NSStringFromRange(ranges[0]), NSStringFromRange(NSMakeRange(1, 2)))
    XCTAssertEqual(NSStringFromRange(ranges[1]), NSStringFromRange(NSMakeRange(4, 2)))
  }

  func testFirstLastRange() {
    // given
    let set = NSIndexSet(indexes: [0, 9])
    // when
    let firstRange = set.firstRange
    let lastRange = set.lastRange
    // then
    XCTAssertNotNil(firstRange)
    XCTAssertNotNil(lastRange)
    XCTAssertEqual(NSStringFromRange(firstRange!), NSStringFromRange(NSMakeRange(0, 1)))
    XCTAssertEqual(NSStringFromRange(lastRange!), NSStringFromRange(NSMakeRange(9, 1)))
  }

}
