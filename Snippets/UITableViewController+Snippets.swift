// Snippets UITableViewController+Snippets.swift
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

import UIKit

extension UITableViewController {

  /// Selects a table view row and notifies the table view delegate, if
  /// present. Normally users select rows; not usually table view
  /// controllers. This method does the same thing but programmatically.
  ///
  /// Take care not to recurse when using this method. Avoid invoking it within
  /// a table view delegate method in response, directly or indirectly, to a
  /// table row selection event. The implementation does not know, nor can know,
  /// that the delegate has already been invoked.
  public func selectRowAtIndexPath(indexPath: NSIndexPath, animated: Bool, scrollPosition: UITableViewScrollPosition) {
    tableView.selectRowAtIndexPath(indexPath, animated: animated, scrollPosition: scrollPosition)
    tableView.delegate?.tableView?(tableView, didSelectRowAtIndexPath: indexPath)
  }

}
