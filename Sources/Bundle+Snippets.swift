// Snippets NSBundle+Snippets.swift
//
// Copyright © 2008–2015, Roy Ratcliffe, Pioneering Software, United Kingdom
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

extension Bundle {

  /// Loads an immutable property list from a named resource within a named
  /// sub-directory. Fails by answering `nil` if the resource does not exist, or
  /// it fails to load. Throws an error if the data loads but fails to decode as
  /// a properly-formatted property list.
  ///
  /// For some reason, `URLForResource` has an optional name parameter. Apple
  /// documentation does not make it clear what happens if the name is
  /// `nil`. This method does not follow the same pattern. The name string is
  /// *not* optional.
  public func propertyList(forResource name: String, subdirectory: String?) throws -> Any? {
    guard let URL = url(forResource: name, withExtension: "plist", subdirectory: subdirectory) else {
      return nil
    }
    guard let data = try? Data(contentsOf: URL) else {
      return nil
    }
    return try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.MutabilityOptions(), format: nil)
  }

  /// - returns: Bundle's display name; returns the application's display name
  ///   if applied to the application's main bundle,
  ///   i.e. `NSBundle.mainBundle().displayName` gives you the application
  ///   display name.
  ///
  /// See Technical Q&A QA1544 for more details.
  ///
  /// Note that some users enable "Show all filename extensions" in Finder. With
  /// that option enabled, the application display name becomes
  /// AppDisplayName.app rather than just AppDisplayName. The displayName
  /// implementation removes the `app` extension so that when creating an
  /// Application Support folder by this name, for example, the new support
  /// folder does not also carry the `app` extension.
  public var displayName: String {
    let manager = FileManager.default
    let displayName = manager.displayName(atPath: bundlePath) as NSString
    return displayName.deletingPathExtension
  }

  /// - parameter subpath: sub-folder within this bundle.
  /// - returns: an array of storyboard names found in this bundle.
  ///
  /// Compiled storyboards have the `storyboardc` extension; `c` standing for
  /// compiled, presumably.
  public func storyboardNames(inDirectory subpath: String?) -> [String] {
    return paths(forResourcesOfType: "storyboardc", inDirectory: subpath).map { path in
      let component = (path as NSString).lastPathComponent
      return (component as NSString).deletingPathExtension
    }
  }

}
