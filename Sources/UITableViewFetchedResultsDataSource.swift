// Snippets UITableViewFetchedResultsDataSource.swift
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

public class UITableViewFetchedResultsDataSource<Result: NSFetchRequestResult>: NSObject, UITableViewDataSource {

  public var fetchedResultsController: NSFetchedResultsController<Result>!
  public var cellIdentifierForRowBlock: ((_ indexPath: IndexPath, _ object: NSManagedObject) -> String)!
  public var configureCellForObjectBlock: ((_ cell: UITableViewCell, _ object: NSManagedObject) -> Void)!

  public func object(at indexPath: IndexPath) -> NSManagedObject {
    // swiftlint:disable:next force_cast
    return fetchedResultsController.object(at: indexPath) as! NSManagedObject
  }
  public func cellIdentifier(forRow indexPath: IndexPath) -> String {
    let object = self.object(at: indexPath)
    return cellIdentifierForRowBlock(indexPath, object)
  }

  //----------------------------------------------------------------------------
  // MARK: - UI Table View Data Source

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let sections = fetchedResultsController.sections {
      return sections[section].numberOfObjects
    } else {
      // There are no sections, only one section for everything. In that case,
      // use the context and fetch request to count everything. Log any errors.
      let context = fetchedResultsController.managedObjectContext
      let request = fetchedResultsController.fetchRequest
      do {
        return try context.count(for: request)
      } catch {
        NSLog("%@", error.localizedDescription)
      }
      return 0
    }
  }

  // - returns: Answers a configured cell for each row and section.
  //
  // For every index path, the data source needs to provide a cell identifier
  // closure, and a configuration closure. They cannot be the same closure
  // because the cell-for-row behaviour requires the the table view cell
  // dequeues before configuration of the cell: path becomes cell identifier,
  // cell identifier becomes cell, finally cell receives configuration.
  //
  // The implementation includes implicit Swift bang operators. They can
  // explode! They *will* throw if you do not set up blocks for providing a cell
  // identifier and for configuring a cell. You need both before the data source
  // starts operating.
  //
  // Does `NSFetchedResultsController` method `objectAtIndexPath` answer `nil`?
  // Have you prefetched the objects using `performFetch`? Pre-fetching is
  // mandatory.
  //
  // The cell-identifier-for-row block has access to the row's managed object,
  // as well as the row's index path. The block can ignore it, if not useful,
  // but the block might also use it to select the cell identifier based on the
  // state of the object.
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = self.cellIdentifier(forRow: indexPath)
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    configureCellForObjectBlock(cell, object(at: indexPath))
    return cell
  }

  // - returns: Answers the number of sections.
  //
  // If there are no sections in the fetched results then answer one
  // section. Otherwise you will see nothing in the table view. Zero sections
  // displays nothing at all. Always return one section when no sections
  // exist. The one and only section contains everything.
  public func numberOfSections(in tableView: UITableView) -> Int {
    if let sections = fetchedResultsController.sections {
      return sections.count
    } else {
      return 1
    }
  }

  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if let sections = fetchedResultsController.sections {
      return sections[section].name
    } else {
      return nil
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Section Index

  public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return fetchedResultsController.sectionIndexTitles
  }

  public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
    return fetchedResultsController.section(forSectionIndexTitle: title, at: index)
  }

}
