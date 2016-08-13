// SnippetsTests ConfigurationTests.swift
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

class ConfigurationTests: XCTestCase {

  let configuration = Configuration()

  override func setUp() {
    super.setUp()

    // given
    configuration.add(forKey: "configuration") { () -> AnyObject in
      return self.configuration
    }
  }

  /// This test only succeeds when the dictionary remains empty. This is true
  /// because mutable dictionaries do not respond to selectors based on their
  /// keys, i.e. they do not respond to `setX:` even though they contain a pair
  /// with key equal to `X`.
  func testConfigureDictionary() {
    // and given
    let dictionary = NSMutableDictionary()
    // when
    _ = configuration.configure(object: dictionary)
    // then
    let value = dictionary["configuration"]
    XCTAssertNil(value)
  }

  func testConfigureObject() {
    // and given
    // swiftlint:disable:next nesting
    class Object: NSObject {
      @objc var configuration: Configuration?
    }
    let object = Object()
    // when
    _ = self.configuration.configure(object: object)
    // then
    let configuration = object.value(forKey: "configuration")
    XCTAssertNotNil(configuration)
    XCTAssert(configuration === self.configuration)
  }

}
