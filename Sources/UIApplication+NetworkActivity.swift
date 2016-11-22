// Snippets UIApplication+NetworkActivity.swift
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

import UIKit

extension UIApplication {

  struct NetworkActivity {
    static var indicatorVisibility: UInt8 = 0
  }

  /// Indicator visibility is an integer. The indicator becomes visible when the
  /// level increments from zero to one; invisible when it decrements from one
  /// to zero. All other transitions do nothing. Do not directly set the
  /// indicator visibility; instead, use the show and hide methods.
  public private(set) var networkActivityIndicatorVisibility: Int {
    get {
      return (objc_getAssociatedObject(self, &UIApplication.NetworkActivity.indicatorVisibility) as? NSNumber ?? NSNumber(integerLiteral: 0)).intValue
    }
    set {
      objc_setAssociatedObject(self, &UIApplication.NetworkActivity.indicatorVisibility, NSNumber(integerLiteral: newValue), .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
  }

  /// Increments the indicator visibility. Makes the indicator visible when the
  /// visibility level transitions from zero to one.
  ///
  /// Application property `isNetworkActivityIndicatorVisible` is true when the
  /// app shows network activity using a spinning gear in the status bar; false
  /// when not.
  public func showNetworkActivityIndicator() {
    let visibility = networkActivityIndicatorVisibility
    networkActivityIndicatorVisibility = visibility + 1
    if visibility == 0 {
      isNetworkActivityIndicatorVisible = true
    }
  }

  /// Makes the network activity indicator invisible when the visibility level
  /// decrements from one to zero.
  public func hideNetworkActivityIndicator() {
    let visibility = networkActivityIndicatorVisibility
    networkActivityIndicatorVisibility = visibility - 1
    if visibility == 1 {
      isNetworkActivityIndicatorVisible = false
    }
  }

}
