[![Build Status](https://travis-ci.org/royratcliffe/Snippets.svg?branch=master)](https://travis-ci.org/royratcliffe/Snippets)

# Snippets for Swift

What can you do with the Snippets framework?

- [`Array` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/Array%2BSnippets.swift)
- [`Bundle` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/Bundle%2BSnippets.swift)
- [`Data` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/Data%2BSnippets.swift)
- [`Date` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/Date%2BSnippets.swift)
- [`NSError` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/NSError%2BSnippets.swift)
- [`NSIndexSet` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/NSIndexSet%2BSnippets.swift)
- [`NSObject` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/NSObject%2BSnippets.swift)
- [`NSObject` associated-object extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/NSObject%2BAssociatedObject.swift)
- [`NSObject` weak-reference extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/NSObject%2BWeakRef.swift)
- [`NSPredicate` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/NSPredicate%2BSnippets.swift)
- [`NSRange` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/NSRange%2BSnippets.swift)
- [`Selector` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/Selector%2BSnippets.swift)
- [`Sequence` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/Sequence%2BSnippets.swift)
- [`Sequence` Boolean extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/Sequence%2BBool.swift)
- [`String` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/String%2BSnippets.swift)
- [`TimeInterval` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/TimeInterval%2BSnippets.swift)
- [`UIApplication` network activity extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/UIApplication%2BNetworkActivity.swift)
- [`UIColor` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/UIColor%2BSnippets.swift)
- [`UIDevice` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/UIDevice%2BSnippets.swift)
- [`UITableViewController` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/UITableViewController%2BSnippets.swift)
- [`UIViewController` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/UIViewController%2BSnippets.swift)
- [`UserDefaults` extensions](https://github.com/royratcliffe/Snippets/blob/master/Sources/UserDefaults%2BSnippets.swift)

See the classes themselves for full details. The following sections provide some usage examples.

[Work in Progress]

## Create Random User

Generate a random user: lorem ipsum, but for people.

```swift
import Snippets

    // Initialise a random-user connection.
    let randomUser = RandomUser()

    // Generate random user information.
    randomUser.get { (randomUser) in
      let results = randomUser["results"] as? [NSDictionary]
      let nat = results?.first?["nat"] as? String
      let info = randomUser["info"] as? NSDictionary
      let seed = info?["seed"] as? String
      let version = info?["version"] as? String
      
      // Do something with the random-user information.
    }
```

## Change Log

See up-to-date change log [here](https://github.com/royratcliffe/Snippets/blob/master/CHANGELOG.md).

