// Snippets TimedIdleObserver.swift
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

import Foundation

/// Something that observes timed-idle notifications. Adds itself to the default
/// notification centre automatically.
open class TimedIdleObserver {

  @objc open func observed(timedIdle notification: Notification) {}

  /// - parameter notifier: Defines which timed-idle notifier to
  ///   observe. Observes all timed-idle notifications if none specified.
  public init(notifier: TimedIdleNotifier? = nil) {
    let center = NotificationCenter.default
    center.addObserver(self, selector: #selector(observed(timedIdle:)), name: .TimedIdle, object: notifier)
  }

  deinit {
    let center = NotificationCenter.default
    center.removeObserver(self)
  }

}
