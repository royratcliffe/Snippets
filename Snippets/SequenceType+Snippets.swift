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

extension SequenceType {

  /// Groups a sequence by the results of the given block.
  /// - parameter block: answers a group for a given element.
  /// - returns: a dictionary of groups where the keys derive from the evaluated
  ///   results of the block, and the values are arrays of elements belonging to
  ///   each group. The array values preserve the order of the original
  ///   sequence.
  public func groupBy(block: (Generator.Element) -> NSObject) -> [NSObject: [Generator.Element]] {
    typealias Element = Generator.Element
    var groups = [NSObject: [Element]]()
    forEach { (element) -> () in
      let group = block(element)
      if var values = groups[group] {
        values.append(element)
        groups[group] = values
      }
      else {
        groups[group] = [element]
      }
    }
    return groups
  }

}
