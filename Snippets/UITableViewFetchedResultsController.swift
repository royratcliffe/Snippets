// Snippets UITableViewFetchedResultsController.swift
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
import CoreData

public class UITableViewFetchedResultsController: UITableViewController, NSFetchedResultsControllerDelegate {

  /// Use `prepareForSegue` to propagate the managed-object context. The
  /// controller needs one.
  public weak var managedObjectContext: NSManagedObjectContext!

  public func performFetch() {
    // Disable error propagation.
    do {
      try fetchedResultsController.performFetch()
    } catch {
      NSLog("%@", (error as NSError).localizedDescription)
      abort()
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - UI Table View Fetched Results Data Source

  let dataSource = UITableViewFetchedResultsDataSource()

  // Delegate to the embedded data source.

  /// Initialises the data source's fetched results controller if not already
  /// set up. Uses user-defined run-time attributes to derive the entity
  /// description and sort descriptor, and optionally also the section name
  /// key-path and cache name.
  public var fetchedResultsController: NSFetchedResultsController {
    if dataSource.fetchedResultsController == nil {
      dataSource.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                       managedObjectContext: managedObjectContext,
                                                                       sectionNameKeyPath: sectionNameKeyPath,
                                                                       cacheName: cacheName)
      dataSource.fetchedResultsController.delegate = self
    }
    return dataSource.fetchedResultsController
  }

  public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.tableView(tableView, numberOfRowsInSection: section)
  }
  public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return dataSource.tableView(tableView, cellForRowAtIndexPath: indexPath)
  }
  public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return dataSource.numberOfSectionsInTableView(tableView)
  }
  public override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return dataSource.tableView(tableView, titleForHeaderInSection: section)
  }

  //----------------------------------------------------------------------------
  // MARK: - User-Defined Run-Time Attributes

  @IBInspectable var entityName: String!
  @IBInspectable var sortDescriptorKey: String!
  @IBInspectable var sortDescriptorAscending: Bool?

  @IBInspectable var sectionNameKeyPath: String?
  @IBInspectable var cacheName: String?

  public var entity: NSEntityDescription? {
    return NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedObjectContext)
  }

  /// Constructs a fetch request based on the controller's user-defined run-time
  /// attributes: its entity name, sort descriptor key and ascending flag. An
  /// instance of `NSFetchedResultsController` requires a fetch request *with*
  /// sort descriptors. Otherwise you will get an exception to that effect.
  /// - returns: Answers a pre-configured fetch request.
  public var fetchRequest: NSFetchRequest {
    let request = NSFetchRequest()
    request.entity = entity
    let descriptor = NSSortDescriptor(key: sortDescriptorKey, ascending: sortDescriptorAscending ?? true)
    request.sortDescriptors = [descriptor]
    return request
  }

  //----------------------------------------------------------------------------
  // MARK: - UI View Controller

  // Sets up the table view data source and performs the initial pre-fetch. This
  // assumes that you have already set up the cell-identifier-for-row and
  // configure-cell-for-object blocks, or will do so soon before the table view
  // starts to load.
  public override func viewDidLoad() {
    super.viewDidLoad()
    if tableView.dataSource == nil {
      tableView.dataSource = dataSource
    }
    performFetch()
  }

  //----------------------------------------------------------------------------
  // MARK: - UI Table View Delegate

  // Table view controllers automatically include the table view delegate
  // protocol. Implement part of that protocol for setting up dynamic table row
  // heights. Dequeue a non-indexed re-usable cell. Important that the cell is
  // not dequeued with an index path because the dequeuing will otherwise
  // recurse. Configure the cell and send back the height of the compressed
  // fitting size. This relies on an explicit preferred width and constraints
  // properly set up. If there are no constraints, use the cell's frame height.
  public override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let cellIdentifier = dataSource.cellIdentifierForRow(indexPath)
    guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else {
      return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    let object = dataSource.objectAtIndexPath(indexPath)
    dataSource.configureCellForObjectBlock(cell: cell, object: object)
    guard !cell.constraints.isEmpty else {
      return cell.frame.height
    }
    return cell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
  }

  //----------------------------------------------------------------------------
  // MARK: - Fetched Results Controller Delegate

  public func controller(controller: NSFetchedResultsController,
                         didChangeObject anObject: AnyObject,
                         atIndexPath indexPath: NSIndexPath?,
                         forChangeType type: NSFetchedResultsChangeType,
                         newIndexPath: NSIndexPath?) {
    switch type {
    case .Insert:
      tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
    case .Delete:
      tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
    case .Move:
      if indexPath != newIndexPath {
        tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
      }
    case .Update:
      // Nothing to delete, nothing to insert.
      tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
    }
  }
  public func controllerWillChangeContent(controller: NSFetchedResultsController) {
    tableView.beginUpdates()
  }
  public func controllerDidChangeContent(controller: NSFetchedResultsController) {
    tableView.endUpdates()
  }

}
