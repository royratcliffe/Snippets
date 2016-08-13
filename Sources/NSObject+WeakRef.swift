// Snippets NSObject+WeakRef.swift
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

import Foundation

extension NSObject {

  //----------------------------------------------------------------------------
  // MARK: - Associated Objects (Weak Ref)
  //----------------------------------------------------------------------------

  /// Associates an object with this object by *weakly* retaining it.
  ///
  /// Only retains non-nil objects weakly. Weakly-retaining nil retains nil
  /// rather than strongly retaining a weak reference to nil.
  public func retainWeaklyAssociated(object: AnyObject?, forKey key: String) {
    retainAssociated(object: object != nil ? WeakRef(object: object) : nil, forKey: key)
  }

  /// - returns: a weakly-retained object, or `nil` if there is no such
  ///   associated object or if the object has been freed.
  ///
  /// Importantly, the associated object gets unwrapped as a WeakRef instance,
  /// or `nil`. Answer is `nil` unless the object really is a weak reference; it
  /// may not be. Funny things happen to Swift otherwise. Answers `nil` if the
  /// associated object is *not* a WeakRef instance.
  public func weaklyAssociatedObject(forKey key: String) -> AnyObject? {
    guard let weakRef = associatedObject(forKey: key) as? WeakRef else {
      return nil
    }
    return weakRef.object
  }

}
