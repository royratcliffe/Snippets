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

  @IBOutlet public var segmentedControl: UISegmentedControl?

  @IBInspectable public var storyboardIdentifiers: String?

  @IBInspectable public var transitionDuration: TimeInterval?

  /// Responds to changes in the segmented control. Connect a segmented
  /// control's value changed event to this action.
  @IBAction open func segmentedControlValueChanged(_ sender: AnyObject?) {
    if let sender = sender as? UISegmentedControl {
      select(segment: sender.selectedSegmentIndex)
    }
  }

  /// Selects a segment.
  /// - parameter index: Index of the segment to select.
  ///
  /// The destination content controller may be `nil`. In such a case, selecting
  /// a segment hides any current content. If the segmented content view
  /// controller finds the segmented control outlet connected, it temporarily
  /// disables control interaction during the transition. However, the
  /// transition only disables interaction if there is a transition from content
  /// to new content. It remains enabled if there is no existing content, or
  /// there is no new content; hence no transition from something to something
  /// else.
  open func select(segment index: Int) {
    let source = childViewControllers.first
    let identifier = allStoryboardIdentifiers[index]
    let destination = storyboard?.instantiateViewController(withIdentifier: identifier)
    var transition = Transition(controller: self)
    if let destination = destination {
      _ = configuration?.configure(object: destination)
      transition.addAnimations {
        destination.view.frame = self.view.bounds
      }
      if let segmentedControl = segmentedControl, source != nil {
        segmentedControl.isUserInteractionEnabled = false
        transition.addCompletion { (finished) in
          segmentedControl.isUserInteractionEnabled = true
        }
      }
    }
    transition.cycle(from: source, to: destination, duration: transitionDuration ?? 0.1)
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
