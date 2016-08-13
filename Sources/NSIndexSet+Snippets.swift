// Snippets NSIndexSet+Snippets.swift
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

extension NSIndexSet {

  /// - returns: the first available range unless there are no indexes because
  ///   the index set is empty.
  public var firstRange: NSRange? {
    var firstRange: NSRange?
    enumerateRanges(options: []) { (range, stop) -> Void in
      firstRange = range
      stop.pointee = true
    }
    return firstRange
  }

  /// - returns: the last range in the index set, or `nil` if an empty set.
  public var lastRange: NSRange? {
    var lastRange: NSRange?
    enumerateRanges(options: .reverse) { (range, stop) -> Void in
      lastRange = range
      stop.pointee = true
    }
    return lastRange
  }

  /// - returns: an array of ranges.
  ///
  /// Index sets internally implement the set as a collection of NSRange
  /// objects. Enumerates all ranges, constructing an immutable array of
  /// ranges. Returns the result.
  public var ranges: [NSRange] {
    var ranges = [NSRange]()
    enumerateRanges(options: []) { (range, _) -> Void in
      ranges.append(range)
    }
    return ranges
  }

  /// Adds this index set to another.
  public func union(_ other: IndexSet) -> IndexSet {
    let selfPlusOther = NSMutableIndexSet()
    selfPlusOther.add(self as IndexSet)
    selfPlusOther.add(other)
    return selfPlusOther as IndexSet
  }

  /// - returns: the set of all indexes in this set that also belong to another.
  public func intersect(_ other: IndexSet) -> IndexSet {
    let intersect = NSMutableIndexSet()
    intersect.add(self as IndexSet)
    intersect.add(other)
    intersect.remove(symmetricDifference(other))
    return intersect as IndexSet
  }

  /// Computes the difference between two index sets excluding any indexes in
  /// common. This amounts to computing the set: self minus the other, plus the
  /// other minus self.
  /// - returns: the difference between this index set and another index set
  ///   where the symmetric result *excludes* indexes that appear in both this
  ///   and the other set.
  public func symmetricDifference(_ other: IndexSet) -> IndexSet {
    let otherMinusSelf = NSMutableIndexSet()
    otherMinusSelf.add(other)
    otherMinusSelf.remove(self as IndexSet)

    let selfMinusOtherPlusOtherMinusSelf = NSMutableIndexSet()
    selfMinusOtherPlusOtherMinusSelf.add(self as IndexSet)
    selfMinusOtherPlusOtherMinusSelf.remove(other)
    selfMinusOtherPlusOtherMinusSelf.add(otherMinusSelf as IndexSet)
    return selfMinusOtherPlusOtherMinusSelf as IndexSet
  }

  /// Conveniently constructs a new index set using an array of indexes.
  public convenience init(indexes: [Int]) {
    let indexSet = NSMutableIndexSet()
    for index in indexes {
      indexSet.add(index)
    }
    self.init(indexSet: indexSet as IndexSet)
  }

}
