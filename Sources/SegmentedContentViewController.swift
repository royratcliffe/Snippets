// Snippets SegmentedContentViewController.swift
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

import UIKit

/// View controller that reacts to segmented control actions by switching
/// content between other view controllers. Instantiates the view controllers by
/// their identifiers using this controller's storyboard.
open class SegmentedContentViewController: UIViewController {

  public var configuration: Configuration?

  @IBInspectable public var storyboardIdentifiers: String?

  /// Responds to changes in the segmented control. Connect a segmented
  /// control's value changed event to this action.
  @IBAction open func segmentedControlValueChanged(_ sender: AnyObject?) {
    if let sender = sender as? UISegmentedControl {
      select(segment: sender.selectedSegmentIndex)
    }
  }

  /// Selects a segment.
  open func select(segment index: Int) {
    let identifier = allStoryboardIdentifiers[index]
    if let destination = storyboard?.instantiateViewController(withIdentifier: identifier) {
      if let source = childViewControllers.first {
        hide(content: source)
      }
      _ = configuration?.configure(object: destination)
      display(content: destination) { (view) in
        view.bounds
      }
    }
  }

  /// Storyboard identifiers as an array of strings, one or more. Cuts up the
  /// storyboard identifiers string using comma delimiters. Throws away leading
  /// and trailing white-spaces.
  public var allStoryboardIdentifiers: [String] {
    return (storyboardIdentifiers ?? "").components(separatedBy: ",").map { (identifier) in
      identifier.trimmingCharacters(in: CharacterSet.whitespaces)
    }
  }

  open override func viewDidLoad() {
    super.viewDidLoad()

    select(segment: 0)
  }

}
