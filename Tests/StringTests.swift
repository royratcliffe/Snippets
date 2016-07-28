// SnippetsTests StringTests.swift
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
@testable import Snippets

class StringTests: XCTestCase {

  func testToInternetAddressIPv4() {
    let internetAddress = try? "127.0.0.1".toInternetAddressIPv4()
    // *** Cannot invoke 'XCTAssertNotNil' with an argument list of type '(in_addr?)'
    XCTAssertTrue(internetAddress != nil)

    let addr = CFSwapInt32BigToHost(internetAddress!.s_addr)
    XCTAssertEqual(addr >> 24, 127)
    XCTAssertEqual((addr >> 16) & 0xff, 0)
    XCTAssertEqual((addr >> 8) & 0xff, 0)
    XCTAssertEqual(addr & 0xff, 1)
  }

  func testIsInternetAddressIPv4() {
    XCTAssertTrue("127.0.0.1".isInternetAddressIPv4)
    XCTAssertFalse("localhost".isInternetAddressIPv4)
  }

  func testToInternetAddressIPv6() {
    let internetAddress = try? "localhost".toInternetAddressIPv6()
    XCTAssertTrue(internetAddress == nil)
  }

  func testIsInternetAddressIPv6() {
    // localhost
    XCTAssertTrue("::1".isInternetAddressIPv6 != nil)

    // any
    XCTAssertTrue("::".isInternetAddressIPv6 != nil)
  }

}
