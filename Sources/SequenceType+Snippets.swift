// Snippets SequenceType+Snippets.swift
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

extension Sequence {

  /// Groups a sequence by the results of the given block.
  /// - parameter block: answers a group for a given element.
  /// - returns: a dictionary of groups where the keys derive from the evaluated
  ///   results of the block, and the values are arrays of elements belonging to
  ///   each group. The array values preserve the order of the original
  ///   sequence.
  public func groupBy(_ block: (Iterator.Element) -> AnyHashable) -> [AnyHashable: [Iterator.Element]] {
    typealias Element = Iterator.Element
    var groups = [AnyHashable: [Element]]()
    forEach { (element) -> () in
      let group = block(element)
      if var values = groups[group] {
        values.append(element)
        groups[group] = values
      } else {
        groups[group] = [element]
      }
    }
    return groups
  }

  /// - parameter block: Block answering true or false for each given element.
  /// - returns: True if all blocks answer true or there are no elements in the
  ///   sequence; in other words, true if there are no blocks answering false.
  ///
  /// Searches for false returned by the block with each sequence element. The
  /// implementation optimises the sequence iteration by searching the sequence
  /// for the first false, then returning. A less-efficient implementation might
  /// first map all the blocks to a sequence of booleans, then search for false;
  /// as follows.
  ///
  ///     return map { (element) -> Bool in
  ///       block(element)
  ///     }.all
  ///
  public func all(_ block: (Iterator.Element) -> Bool) -> Bool {
    for element in self {
      if !block(element) {
        return false
      }
    }
    return true
  }

  /// - parameter block: Block that answers a true or false condition for a
  ///   given sequence element.
  /// - returns: True if any element answers true, false otherwise; false also
  ///   for empty sequences.
  ///
  /// Searches for true. The implementation performs an early-out
  /// optimisation. It calls the block for all the elements until a block
  /// returns true, and immediately returns true thereafter. It does not
  /// continue to iterate through any remaining elements, nor continue to call
  /// the block as the straightforward implementation might, see below. There is
  /// no need.
  ///
  ///     return map { (element) -> Bool in
  ///       block(element)
  ///     }.any
  ///
  public func any(_ block: (Iterator.Element) -> Bool) -> Bool {
    for element in self {
      if block(element) {
        return true
      }
    }
    return false
  }

}
