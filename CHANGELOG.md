# Change Log

## [0.8.0](https://github.com/royratcliffe/snippets/tree/0.8.0) (2016-09-08)

- Added `NSObject.configure(for:)` helper method
- Fix for name changes in Xcode 8.0 Golden Master (8A218a)
- Fix `@escaping` may only be applied to parameters of function type
- Allow `to` as parameter name
- Fetched-results based table-view controller exercises retain-cycle paranoia
- Object implied; use `perform(_:with:)`

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.7.1...0.8.0)

## [0.7.1](https://github.com/royratcliffe/snippets/tree/0.7.1) (2016-09-06)

- Fix segment-control temporary disabled; only if from content to content

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.7.0...0.7.1)

## [0.7.0](https://github.com/royratcliffe/snippets/tree/0.7.0) (2016-09-06)

- Segment select uses content transition with interaction temporarily suspended
- Duration always used; comment fixed
- `UIViewController.Transition` helper

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.6.0...0.7.0)

## [0.6.0](https://github.com/royratcliffe/snippets/tree/0.6.0) (2016-09-01)

- Added SegmentedContentViewController class

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.5.0...0.6.0)

## [0.5.0](https://github.com/royratcliffe/snippets/tree/0.5.0) (2016-09-01)

- Performing fetch catches Core Data errors, deletes cache
- Catch fetch exceptions as `NSError`
- Table-view fetched results controller: open-access to overridable sort descriptors
- Fetched results controller inspectable properties are public

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.4.0...0.5.0)

## [0.4.0](https://github.com/royratcliffe/snippets/tree/0.4.0) (2016-08-31)

- Open access for overridable `UITableViewFetchedResultsController` methods
- Re-use `Selector(setter:)` initialiser
- Selector snippets: `Selector(setter:)`

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.3.0...0.4.0)

## [0.3.0](https://github.com/royratcliffe/snippets/tree/0.3.0) (2016-08-31)

- Date snippets, startOfDay, endOfDay
- Removed NS source file prefix where possible; SequenceType to Sequence

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.2.2...0.3.0)

## [0.2.2](https://github.com/royratcliffe/snippets/tree/0.2.2) (2016-08-25)

- Open super-class, UITableViewFetchedResultsController; not generic

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.2.1...0.2.2)

## [0.2.1](https://github.com/royratcliffe/snippets/tree/0.2.1) (2016-08-18)

- `===` fails to compile unless optional cast to type
- Test for `Data.hexString`
- Swift updates including `Any`, raw pointers, escaping, no function type values, etc.

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.2.0...0.2.1)

## [0.2.0](https://github.com/royratcliffe/snippets/tree/0.2.0) (2016-08-13)

- Merge branch 'feature/swift_3_0' into develop
- Convert to Swift 3.0 syntax using Xcode 8, beta 5
- Upgraded to Xcode 8 (beta 5)
- Disable code signing; enable whole-module optimisation
- Update Travis configuration for Swift 3, Xcode 8
- Removed workspace

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.20...0.2.0)

## [0.1.20](https://github.com/royratcliffe/snippets/tree/0.1.20) (2016-08-01)

- Removed Podfile

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.19...0.1.20)

## [0.1.19](https://github.com/royratcliffe/snippets/tree/0.1.19) (2016-07-28)

- Merge branch 'feature/swift_2_3' into develop
- Adjusted paths to Info.plist's
- Snippets folder renamed to Sources, SnippetTests renamed to Tests
- Upgrade for Xcode 8.x
- Enable whole-module optimisation
- Test for success under iOS 10
- Swift 2.3 throws when countForFetchRequest fails
- Start Swift 2.3 migration

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.18...0.1.19)

## [0.1.18](https://github.com/royratcliffe/snippets/tree/0.1.18) (2016-05-25)

- SequenceType.all and any

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.17...0.1.18)

## [0.1.17](https://github.com/royratcliffe/snippets/tree/0.1.17) (2016-05-20)

- NSObject.setValuesForKeys answers Int
- Travis gives "bin" as the display name
- Share the scheme, for Travis
- Travis configuration

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.16...0.1.17)

## [0.1.16](https://github.com/royratcliffe/snippets/tree/0.1.16) (2016-05-10)

- Switch off conditional binding cascade nags
- Make observeValueForKeyPath public for overriding
- Table-view fetched-results controller has *public* data source
- Adjust indents

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.15...0.1.16)

## [0.1.15](https://github.com/royratcliffe/snippets/tree/0.1.15) (2016-04-27)

Adds NSTimeInterval extensions.

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.14...0.1.15)

## [0.1.14](https://github.com/royratcliffe/snippets/tree/0.1.14) (2016-04-27)

[swiftlint]:https://github.com/realm/SwiftLint

Snippets now conform to [SwiftLint][swiftlint] rules with only minor
exceptions. SwiftLint automatically runs at end of build.

- Clean up Pod description whitespace
- Changelog -> Change Log
- Upgrade random-user API to version 1.0
- Merge branch 'feature/swift_lint' into develop
- Document block parameter; prevent valid_docs Lint violation
- Accept some Lint violations
- Fixed another statement position Lint-violation
- Replaced legacy constructors
- Fix statement position violations
- Open braces moved to end-of-line
- Warn at 150 columns; disable documentation rules
- Split up long line
- Removed trailing semi-colon
- Run swiftlint at end of build
- Variable names begin with lowercase letters
- Shorten long lines
- Avoid as-bang (as!)

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.13...0.1.14)

## [0.1.13](https://github.com/royratcliffe/snippets/tree/0.1.13) (2016-04-25)

- Configuration using keyed value-blocks
- Allow nil block returns when setting values for keys
- Use uppercaseString on substring
- FIX: capitalised string lower-cases everything but the first character
- String methods firstCharacterString and uppercaseFirstCharacterString
- NSOperation.cancelledDependencies method

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.12...0.1.13)

## [0.1.12](https://github.com/royratcliffe/snippets/tree/0.1.12) (2016-04-13)

- Implement KeyValueChange.isPrior
- Comment about KVO retain cycles
- Use rawKind rather than kindNumber
- Key-value changes and their observers
- Added objc_getClasses method

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.11...0.1.12)

## [0.1.11](https://github.com/royratcliffe/snippets/tree/0.1.11) (2016-03-27)

- ObjectFromClassName method added
- Keep Swift extensions together within the project

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.10...0.1.11)

## [0.1.10](https://github.com/royratcliffe/snippets/tree/0.1.10) (2016-03-24)

- NSManagedObjectContext extensions moved to ManagedObject pod

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.9...0.1.10)

## [0.1.9](https://github.com/royratcliffe/snippets/tree/0.1.9) (2016-03-23)

- Swift 2.2 deprecates postfix ++; use a generator instead
- Core Data tests moved to ManagedObject pod
- NSObject.setValuesForKeys method
- Updated for Swift 2.2
- Renamed childContext to newChildContext
- Change log added

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.8...0.1.9)

## [0.1.8](https://github.com/royratcliffe/snippets/tree/0.1.8) (2016-03-21)

- NSBundle.storyboardNames method
- ObjectsDidChangeObserver moved to ManagedObject framework
- ObjectsDidChangeObserver class added
- Give associated-object extensions their own sources

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.7...0.1.8)

## [0.1.7](https://github.com/royratcliffe/snippets/tree/0.1.7) (2016-03-03)

- Selector strings must be precise, trailing colon always needed
- NSObject method -perform:withObject:
- Overload cycleFromContentController with optionals
- Use objc_AssociationPolicy.associationRetain and associationCopy
- Add objc_AssociationPolicy extension to project
- objc_AssociationPolicy extension

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.6...0.1.7)

## [0.1.6](https://github.com/royratcliffe/snippets/tree/0.1.6) (2016-02-19)

- Random user API now version 0.8
- Reformatted fetchFirst
- NSIndexSet.firstRange and lastRange
- SequenceType.groupBy extension
- Filter out duplicate localised description from error's user info
- Use identity operator when comparing class self
- NSIndexSet union, intersect and symmetricDifference methods added

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.5...0.1.6)

## [0.1.5](https://github.com/royratcliffe/snippets/tree/0.1.5) (2016-01-21)

- Ignore Pods sub-folder
- JSON transformer
- Weakly-retaining nil retains nil
- Index-set and range snippets
- Index-set snippets
- Range snippets

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.4...0.1.5)

## [0.1.4](https://github.com/royratcliffe/snippets/tree/0.1.4) (2015-12-29)

- Methods for visible first responders and text fields
- First responder tag is public
- UITableViewController.selectRowAtIndexPath method

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.3...0.1.4)

## [0.1.3](https://github.com/royratcliffe/snippets/tree/0.1.3) (2015-12-29)

- Log regular-expression compilation failure
- Snippets project
- Text-field table view controller
- Tests for NSError
- Right-justify error keys

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.2...0.1.3)

## [0.1.2](https://github.com/royratcliffe/snippets/tree/0.1.2) (2015-12-27)

- UIColor.fromHTML(string) implementation
- Associated objects, including weakly retained

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.1...0.1.2)

## [0.1.1](https://github.com/royratcliffe/snippets/tree/0.1.1) (2015-12-16)

- Use option initialiser with array, rather than raw value
- Managed object context has childContext(concurrencyType) method
- Workspace with Pods
- Xcode 7.1.1 checks
- NSData snippets and RandomUser added to project
- WeakRef added to project
- WeakRef class
- Workspace for use with CocoaPods
- Add files to projects: NSData, NSError extensions; RandomUser
- NSError.log method
- Use UInt8 rather than CChar; drop unnecessary .2 format precision
- CocoaPods wants a summary and description
- CocoaPods support added
- Note about NSInternalInconsistencyException
- Merge branch 'feature/bundle_display_name' into develop
- Xcode removes asset tags; added bundle tests
- Based on work from 2008
- Main bundle display name test
- NSBundle's displayName
- RandomUser comments
- Avoid setting up empty query items
- Random user
- Convert data to a hexadecimal string
- Tidying up
- Dispatch queues

[Full Change Log](https://github.com/royratcliffe/snippets/compare/0.1.0...0.1.1)

## [0.1.0](https://github.com/royratcliffe/snippets/tree/0.1.0) (2015-12-11)

Initial version.
