// Snippets objc_getClasses.swift
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

/// Obtains all registered Objective-C classes.
/// - returns: an array of AnyClass types, one for each Objective-C class. The
///   array is only a sample of the classes at the current point in time. It
///   does not include any classes not yet registered. Therefore, two calls to
///   *get* the classes may answer two different arrays.
public func objc_getClasses() -> [AnyClass] {
  var classes = [AnyClass]()
  let classCount = objc_getClassList(nil, 0)
  let classList = UnsafeMutablePointer<AnyClass?>.alloc(Int(classCount))
  defer { classList.dealloc(Int(classCount)) }
  let classBuffer = AutoreleasingUnsafeMutablePointer<AnyClass?>(classList)
  objc_getClassList(classBuffer, classCount)
  for classIndex in 0..<classCount {
    guard let anyClass = classList[Int(classIndex)] else { continue }
    classes.append(anyClass)
  }
  return classes
}

/// Convenience method for obtaining all Objective-C class names.
public func objc_getClassNames() -> [String] {
  return objc_getClasses().map { (anyClass) -> String in
    NSStringFromClass(anyClass)
  }
}
