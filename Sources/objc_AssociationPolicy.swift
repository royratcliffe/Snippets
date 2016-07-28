// Snippets objc_AssociationPolicy.swift
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

extension objc_AssociationPolicy {

  /// - returns: platform-dependent retain policy. Answers the non-atomic
  ///   version of the retain policy on iOS and Apple TV platforms. Returns
  ///   atomic retain on non-iOS platforms, i.e. Mac OS X.
  public static var associationRetain: objc_AssociationPolicy {
    #if os(OSX)
      return objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
    #else
      return objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
    #endif
  }

  /// - returns: atomic copy policy for OS X platforms, non-atomic for other
  ///   platforms including iOS and Apple TV OS.
  public static var associationCopy: objc_AssociationPolicy {
    #if os(OSX)
      return objc_AssociationPolicy.OBJC_ASSOCIATION_COPY
    #else
      return objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC
    #endif
  }

}
