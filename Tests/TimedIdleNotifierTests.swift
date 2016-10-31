// SnippetsTests TimedIdleNotifierTests.swift
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

class TimedIdleNotifierTests: XCTestCase {

  func testTwoOrThreeNotifications() {
    // given
    let notifier = TimedIdleNotifier()
    notifier.schedule(timeInterval: 1.0)
    var counter = 0
    let observer = NotificationCenter.default.addObserver(forName: .TimedIdle, object: notifier, queue: nil) { (notification) in
      counter += 1
    }

    // when
    RunLoop.main.run(until: Date(timeIntervalSinceNow: 3.0))

    // then
    XCTAssertTrue((2...3).contains(counter))
    NotificationCenter.default.removeObserver(observer)
  }

  func testObserver() {
    // given
    let notifier = TimedIdleNotifier()
    notifier.schedule(timeInterval: 1.0)
    // swiftlint:disable:next nesting
    class Observer: TimedIdleObserver {
      var dates = [Date]()
      public override func observed(timedIdle notification: Notification) {
        dates.append(Date())
      }
    }
    let observer = Observer(notifier: notifier)

    // when
    RunLoop.main.run(until: Date(timeIntervalSinceNow: 3.0))

    // then
    XCTAssertTrue((2...3).contains(observer.dates.count))
  }

}
