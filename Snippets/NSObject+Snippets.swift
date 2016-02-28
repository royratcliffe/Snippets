// Snippets NSObject+Snippets.swift
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

  public class var objCRuntimePropertyNames: [String] {
    var count: UInt32 = 0
    var propertyNames = [String]()
    let propertyList = class_copyPropertyList(self, &count)
    if propertyList != nil {
      for index in 0..<Int(count) {
        let name = property_getName(propertyList[index])
        propertyNames.append(NSString(UTF8String: name) as! String)
      }
      free(propertyList)
    }
    return propertyNames
  }

  public var objCRuntimePropertyNames: [String] {
    return self.dynamicType.objCRuntimePropertyNames
  }

  public var objCRuntimeProperties: [String: AnyObject] {
    var properties = [String: AnyObject]()
    for name in objCRuntimePropertyNames {
      if let value = valueForKey(name) {
        properties[name] = value
      }
    }
    return properties
  }

  //----------------------------------------------------------------------------
  // MARK: - Associated Objects
  //----------------------------------------------------------------------------

  /// - returns: a unique void-pointer given a string. Always answers the same
  ///   void pointer for the same string. Reuses the Objective-C
  ///   selector-from-string mechanism to manufacture an atomic string, by
  ///   default. Object classes or object instance can freely override the
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

  //----------------------------------------------------------------------------
  // MARK: - Associated Objects (Weak Ref)
  //----------------------------------------------------------------------------

  /// Associates an object with this object by *weakly* retaining it.
  ///
  /// Only retains non-nil objects weakly. Weakly-retaining nil retains nil
  /// rather than strongly retaining a weak reference to nil.
  public func retainWeaklyAssociatedObject(object: AnyObject?, forKey key: String) {
    retainAssociatedObject(object != nil ? WeakRef(object: object) : nil, forKey: key)
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
