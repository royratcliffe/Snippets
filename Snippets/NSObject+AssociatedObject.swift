// Snippets NSObject+AssociatedObject.swift
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
  // MARK: - Associated Objects
  //----------------------------------------------------------------------------

  /// - returns: a unique void-pointer given a string. Always answers the same
  ///   void pointer for the same string. Reuses the Objective-C
  ///   selector-from-string mechanism to manufacture an atomic string, by
  ///   default. Object classes or object instance can freely override this
  ///   default mapping of strings to void pointers.
  public func associatedObjectKey(key: String) -> UnsafePointer<Void> {
    return unsafeBitCast(Selector(key), UnsafePointer<Void>.self)
  }

  /// Associates an object with this object by assignment.
  public func assignAssociatedObject(object: AnyObject?, forKey key: String) {
    objc_setAssociatedObject(self, associatedObjectKey(key), object, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
  }

  /// Associates an object with this object by retaining it.
  public func retainAssociatedObject(object: AnyObject?, forKey key: String) {
    objc_setAssociatedObject(self, associatedObjectKey(key), object, objc_AssociationPolicy.associationRetain)
  }

  /// Associates an object with this object by copying it.
  public func copyAssociatedObject(object: AnyObject?, forKey key: String) {
    objc_setAssociatedObject(self, associatedObjectKey(key), object, objc_AssociationPolicy.associationCopy)
  }

  public func associatedObject(forKey key: String) -> AnyObject? {
    return objc_getAssociatedObject(self, associatedObjectKey(key))
  }

  public func removeAssociatedObjects() {
    objc_removeAssociatedObjects(self)
  }

}
