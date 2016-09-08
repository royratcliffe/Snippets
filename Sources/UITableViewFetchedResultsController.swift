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

/// The controller cannot use Swift generics. Subclasses will still be able to
/// inherit from a generic class but Interface Builder will not be able to find
/// the subclass by name when instantiating a storyboard. For this reason, the
/// class uses the basic `NSFetchRequestResult` protocol for the fetch result
/// type which in turn inherits from `NSObjectProtocol`, and hence just
/// represents some basic `NSObject`.
open class UITableViewFetchedResultsController: UITableViewController, NSFetchedResultsControllerDelegate {

  /// Use `prepareForSegue` to propagate the managed-object context. The
  /// controller needs one.
  public weak var managedObjectContext: NSManagedObjectContext!

  /// Performs a fetch request using the fetched results controller. Aborts on
  /// error, unless a Core Data error. Erases the fetched results controller
  /// cache on Core Data errors, before retrying the fetch. Deletes all caches
  /// if no specific cache. Aborts on Core Data errors if the second retry also
  /// fails.
  open func performFetch() {
    // Disable error propagation.
    do {
      try fetchedResultsController.performFetch()
    } catch let error as NSError {
      NSLog("%@", error.localizedDescription)
      abort()
    } catch let error as CocoaError {
      if error.code == CocoaError.Code.coreDataError {
        NSFetchedResultsController<NSFetchRequestResult>.deleteCache(withName: fetchedResultsController.cacheName)
        do {
          try fetchedResultsController.performFetch()
        } catch {
          NSLog("%@", error.localizedDescription)
          abort()
        }
      }
    }
  }

  /// De-initialises the controller. Exercises some retain-cycle paranoia by
  /// disconnecting this view controller from the fetched-results
  /// controller. The delegate reference is unowned and unsafe, not
  /// weak. Therefore the delegate reference does not automatically become `nil`
  /// when the view controller de-allocates from memory. There may be occasions
  /// when an in-flight managed-object change notification from the fetch
  /// controller tries to send change messages to the view controller when the
  /// controller no longer exists. Prevent that from happening by explicitly
  /// disconnecting the two controllers.
  deinit {
    dataSource.fetchedResultsController?.delegate = nil
  }

  //----------------------------------------------------------------------------
  // MARK: - UI Table View Fetched Results Data Source

  /// Gives public access to the data-source object so that controller
  /// sub-classes can access the data source and set up blocks for mapping rows
  /// to cell identifiers and configuring table cells using managed objects.
  public let dataSource = UITableViewFetchedResultsDataSource<NSFetchRequestResult>()

  // Delegate to the embedded data source.

  /// Initialises the data source's fetched results controller if not already
  /// set up. Uses user-defined run-time attributes to derive the entity
  /// description and sort descriptor, and optionally also the section name
  /// key-path and cache name.
  open var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> {
    if dataSource.fetchedResultsController == nil {
      dataSource.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                       managedObjectContext: managedObjectContext,
                                                                       sectionNameKeyPath: sectionNameKeyPath,
                                                                       cacheName: cacheName)
      dataSource.fetchedResultsController.delegate = self
    }
    return dataSource.fetchedResultsController
  }

  open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.tableView(tableView, numberOfRowsInSection: section)
  }

  open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return dataSource.tableView(tableView, cellForRowAt: indexPath)
  }

  open override func numberOfSections(in tableView: UITableView) -> Int {
    return dataSource.numberOfSections(in: tableView)
  }

  open override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return dataSource.tableView(tableView, titleForHeaderInSection: section)
  }

  //----------------------------------------------------------------------------
  // MARK: - User-Defined Run-Time Attributes

  @IBInspectable public var entityName: String!
  @IBInspectable public var sortDescriptorKey: String!
  @IBInspectable public var sortDescriptorAscending: Bool?

  @IBInspectable public var sectionNameKeyPath: String?
  @IBInspectable public var cacheName: String?

  open var entity: NSEntityDescription? {
    return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
  }

  /// Constructs a fetch request based on the controller's user-defined run-time
  /// attributes: its entity name, sort descriptor key and ascending flag. An
  /// instance of `NSFetchedResultsController` requires a fetch request *with*
  /// sort descriptors. Otherwise you will get an exception to that effect.
  /// - returns: Answers a pre-configured fetch request.
  open var fetchRequest: NSFetchRequest<NSFetchRequestResult> {
    let request = NSFetchRequest<NSFetchRequestResult>()
    request.entity = entity
    request.sortDescriptors = sortDescriptors
    return request
  }

  /// Sort descriptors used by the fetch request.
  open var sortDescriptors: [NSSortDescriptor] {
    return [NSSortDescriptor(key: sortDescriptorKey, ascending: sortDescriptorAscending ?? true)]
  }

  //----------------------------------------------------------------------------
  // MARK: - UI View Controller

  // Sets up the table view data source and performs the initial pre-fetch. This
  // assumes that you have already set up the cell-identifier-for-row and
  // configure-cell-for-object blocks, or will do so soon before the table view
  // starts to load.
  open override func viewDidLoad() {
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
  open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let cellIdentifier = dataSource.cellIdentifier(forRow: indexPath)
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
      return super.tableView(tableView, heightForRowAt: indexPath)
    }
    let object = dataSource.object(at: indexPath)
    dataSource.configureCellForObjectBlock(cell, object)
    guard !cell.constraints.isEmpty else {
      return cell.frame.height
    }
    return cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
  }

  //----------------------------------------------------------------------------
  // MARK: - Fetched Results Controller Delegate

  open func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                         didChange anObject: Any,
                         at indexPath: IndexPath?,
                         for type: NSFetchedResultsChangeType,
                         newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      tableView.insertRows(at: [newIndexPath!], with: .fade)
    case .delete:
      tableView.deleteRows(at: [indexPath!], with: .fade)
    case .move:
      if indexPath != newIndexPath {
        tableView.deleteRows(at: [indexPath!], with: .fade)
        tableView.insertRows(at: [newIndexPath!], with: .fade)
      }
    case .update:
      // Nothing to delete, nothing to insert.
      tableView.reloadRows(at: [indexPath!], with: .fade)
    }
  }

  open func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }

  open func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }

}
