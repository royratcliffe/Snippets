// Snippets TimedIdleNotifier.swift
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

/// Combines a timer and an idle notification. Periodically enqueues a
/// timed-idle notification, but only when the run-loop is idle.
public class TimedIdleNotifier {

  var timer: Timer?

  public init() {}

  // De-initialises the notifier. Invalidates the timer, if a timer exists.
  deinit {
    timer?.invalidate()
  }

  /// Invalidates any existing timer. Schedules a new repeating (by default)
  /// timer using the given time interval.
  /// - parameter timeInterval: How often to enqueue the timed-idle
  ///   notification, in seconds. Effectively does nothing if the run-loop
  ///   remains busy when the interval elapses.
  /// - parameter repeats: True if the time interval should enqueue the
  ///   notification continuously, until told otherwise by re-scheduling a
  ///   different time interval.
  public func schedule(timeInterval: TimeInterval, repeats: Bool = true) {
    timer?.invalidate()
    timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(fired(timer:)), userInfo: nil, repeats: repeats)
  }

  /// Runs when timer has fired. Enqueues a timed-idle notification when idle.
  @objc func fired(timer: Timer) {
    enqueue(notification: notification())
  }

  /// Enqueues the given notification when idle. Coalesces it on sender.
  func enqueue(notification: Notification) {
    let queue = NotificationQueue.default
    let runLoopModes = Set([RunLoopMode.defaultRunLoopMode, .commonModes])
    let modes = Array(runLoopModes)
    queue.enqueue(notification, postingStyle: .whenIdle, coalesceMask: .onSender, forModes: modes)
  }

  /// Constructs a new notification using this object.
  func notification() -> Notification {
    return Notification(name: .TimedIdle, object: self, userInfo: nil)
  }

}

extension Notification.Name {

  public static let TimedIdle = Notification.Name("TimedIdle")

}
