// Snippets NSManagedObjectContext+Snippets.swift
//
// Copyright © 2015, Roy Ratcliffe, Pioneering Software, United Kingdom
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

import CoreData

extension NSManagedObjectContext {

  /// Fetches an entity by name.
  /// - parameter entityName: Name of the entity to fetch.
  /// - returns: Array of fetched objects.
  ///
  /// Builds a fetch request using the given entity name. Executes the fetch
  /// request within this context. Answers the resulting array of managed
  /// objects. Throws on error.
  public func fetch(entityName: String) throws -> [AnyObject] {
    let request = NSFetchRequest(entityName: entityName)
    return try executeFetchRequest(request)
  }

  /// Finds the first entity whose key matches a value.
  /// - returns: Optional matching managed object.
  ///
  /// Implementation constructs the comparison predicate programmatically in
  /// order to avoid any issues with escaping string literals. Instead, let the
  /// `NSExpression` handle those machinations.
  public func fetchFirst(entityName: String, by keyPath: String, value: AnyObject) throws -> AnyObject? {
    let request = NSFetchRequest(entityName: entityName)
    let lhs = NSExpression(forKeyPath: keyPath)
    let rhs = NSExpression(forConstantValue: value)
    let modifier = NSComparisonPredicateModifier.DirectPredicateModifier
    let type = NSPredicateOperatorType.EqualToPredicateOperatorType
    let options = NSComparisonPredicateOptions(rawValue: 0)
    request.predicate = NSComparisonPredicate(leftExpression: lhs, rightExpression: rhs, modifier: modifier, type: type, options: options)
    request.fetchLimit = 1
    return try executeFetchRequest(request).first
  }

  /// Inserts a new object.
  /// - parameter entityName: Name of the entity to insert.
  /// - returns: New inserted object.
  ///
  /// If entityName does not exist in the data model, CoreData will throw an
  /// internal consistency exception (NSInternalInconsistencyException) for the
  /// reason that CoreData cannot find the named entity within the model.
  public func insertNewObject(entityName: String) -> NSManagedObject {
    return NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: self)
  }

  /// - returns: a new child managed-object context with private-queue or
  ///   main-queue concurrency. The receiver context becomes the new context's
  ///   parent.
  public func childContext(concurrencyType: NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
    let context = NSManagedObjectContext(concurrencyType: concurrencyType)
    context.parentContext = self
    return context
  }

}
