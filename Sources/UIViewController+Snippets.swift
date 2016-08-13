// Snippets UIViewController+Snippets.swift
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

extension UIViewController {

  /// Displays the given content within this container.
  ///
  /// - parameter content: Content view controller to display within this
  ///     container's content hierarchy.
  ///
  /// - parameter frameForView: Optional capture describing how to set up the
  ///     new content's frame. If not given, the content's frame remains
  ///     unchanged, and therefore assumes that layout constraints will
  ///     determine the view's position and size within the new container. The
  ///     capture's argument takes this container's view and answers the new
  ///     content's frame within that view.
  ///
  /// Adds the other view controller's view to this container's view
  /// hierarchy. Automatically removes the content from any other container
  /// before adding it to this container, invoking
  /// `willMoveToParentViewController` on the content view controller.
  ///
  /// View controllers, amongst other things, can operate as containers for
  /// other content controllers; they have a self-referencing
  /// container-content relationship. Content controllers become children
  /// belonging to a parent container. Content views join the container's view
  /// hierarchy.
  public func display(content: UIViewController,
                      frameForView: ((UIView) -> CGRect)? = nil) {
    addChildViewController(content)
    if let frameForView = frameForView {
      content.view.frame = frameForView(view)
    }
    view.addSubview(content.view)
    content.didMove(toParentViewController: self)
  }

  public func hide(content: UIViewController) {
    content.willMove(toParentViewController: nil)
    content.view.removeFromSuperview()
    content.removeFromParentViewController()
  }

  /// Cycles from an existing content view controller to another new content
  /// view controller. Handles the will- and did-move-to-parent messages for
  /// both the incoming and outgoing view controllers. Removes the existing
  /// content view controller from the parent view controller when animation
  /// finishes.
  public func cycle(from content: UIViewController,
                    // swiftlint:disable:previous function_parameter_count
                    to newContent: UIViewController,
                    duration: TimeInterval,
                    options: UIViewAnimationOptions,
                    newContentStartFrame: CGRect?,
                    contentEndFrame: CGRect?) {
    content.willMove(toParentViewController: nil)
    addChildViewController(newContent)
    if let frame = newContentStartFrame {
      newContent.view.frame = frame
    }
    transition(from: content,
               to: newContent,
               duration: duration,
               options: options,
               animations: {
      newContent.view.frame = content.view.frame
      if let frame = contentEndFrame {
        content.view.frame = frame
      }
    }) { finished in
      content.removeFromParentViewController()
      newContent.didMove(toParentViewController: self)
    }
  }

  /// Cycles, hides or displays content controllers based on the existence of
  /// the controllers: cycles if both the incoming and outgoing controllers
  /// exist; hides if only the outgoing controller exists; or displays if only
  /// the incoming controller exists.
  public func cycle(from content: UIViewController?,
                    // swiftlint:disable:previous function_parameter_count
                    to newContent: UIViewController?,
                    duration: TimeInterval,
                    options: UIViewAnimationOptions,
                    newContentStartFrame: CGRect?,
                    contentEndFrame: CGRect?) {
    if let content = content {
      if let newContent = newContent {
        cycle(from: content,
              to: newContent,
              duration: duration,
              options: options,
              newContentStartFrame: newContentStartFrame,
              contentEndFrame: contentEndFrame)
      } else {
        hide(content: content)
      }
    } else {
      if let newContent = newContent {
        display(content: newContent)
      }
    }
  }

}
