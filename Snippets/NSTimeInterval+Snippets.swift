// Snippets NSTimeInterval+Snippets.swift
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

extension TimeInterval {

  /// - returns: 64-bit unsigned integer conversion of time interval scaled and
  ///   rounded to whole nanoseconds, suitable for Grand-Central Dispatch
  ///   functions. The resulting integer is unsigned even though the
  ///   double-precision time interval used as the source can actually be
  ///   signed, e.g. negative intervals might represent _elapsed_ spans of
  ///   time. This method always ignores the sign however by first converting
  ///   the double-precision interval to an absolute double.
  public var nsecPerSec: DispatchTime {
    return DispatchTime(uptimeNanoseconds: UInt64(abs(self) * TimeInterval(NSEC_PER_SEC)))
  }

}
