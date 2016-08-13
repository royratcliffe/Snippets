// Snippets UITextFieldTableViewController.swift
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

import UIKit

/// Table view controller that handles cells containing text fields. Selecting
/// the cells makes the text fields become the responder and pops up the
/// keyboard. Touching the text fields makes the table view selection follow the
/// text field's enclosing cell. In short, text editing tracks table selection,
/// and table selection tracks editing. Such does not happen automatically.
///
/// In this view controller's usage scenario, there are multiple cell prototypes
/// each containing a text field. Set up the scene as follows: (1) Make each
/// cell's text field tag match the first responder tag, which defaults to a tag
/// of 101. (2) Connect the text fields to the text-field table view controller
/// (an instance of this controller) as their text field delegate. When editing
/// begins, the delegate moves the selection to the corresponding cell.
///
/// Row selection triggers text field editing because the text field (or other
/// control with the first-responder tag) becomes the first responder. Text
/// fields enter editing mode automatically whenever they become first
/// responder; the keyboard pops up. In reverse, table row selection follows
/// changes in text field editing; this assumes that you have wired up the table
/// controller as the delegate for all the text fields.
public class UITextFieldTableViewController: UITableViewController, UITextFieldDelegate {

  /// Tag of the first responder found in each cell. Assumes that there is only
  /// one view with this tag in each cell, somewhere within the cell or the
  /// cell's sub-views. Behaviour undefined if there is more than one with this
  /// tag. The default 101 tag spells TXT using the mnemonic major system.
  @IBInspectable public var firstResponderTag: Int = 101

  /// - returns: all the first-responder views currently visible; or more
  ///   specifically, all the views with matching first-responder tags found in
  ///   the cells currently belonging to the table view.
  ///
  /// Notice that the answer is an array of views, not an array of text fields;
  /// perform a flat map to extract the text fields. See visibleTextFields.
  public var visibleFirstResponders: [UIView] {
    var visibleFirstResponders = [UIView]()
    for cell in tableView.visibleCells {
      if let view = cell.viewWithTag(firstResponderTag) {
        visibleFirstResponders.append(view)
      }
    }
    return visibleFirstResponders
  }

  /// - returns: visible first responders filtered for text fields.
  public var visibleTextFields: [UITextField] {
    return visibleFirstResponders.flatMap { view in
      view as? UITextField
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Table View Data Source
  //----------------------------------------------------------------------------

  public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      if let view = cell.viewWithTag(firstResponderTag) {
        if !view.isFirstResponder {
          view.becomeFirstResponder()
        }
      }
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Text Field Delegate
  //----------------------------------------------------------------------------

  public func textFieldDidBeginEditing(_ textField: UITextField) {
    if let indexPath = tableView.indexPathForRow(at: textField.convert(CGPoint.zero, to: tableView)) {
      if indexPath != tableView.indexPathForSelectedRow {
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
      }
    }
  }

}
