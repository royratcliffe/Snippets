// Snippets RandomUser.swift
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

import Foundation

/// Generates a random user. Provides Lorem Ipsum, but for people.
///
/// See https://randomuser.me for more details. Results in JSON follow the
/// format below. The results delivered to the capture follow the same format,
/// albeit converted to a Foundation dictionary with embedded strings, numbers
/// and arrays.
///
///     {
///       "nationality": "AU",
///       "results": [
///         {
///           "user": {
///             "TFN": "905962256",
///             "cell": "0487-580-783",
///             "dob": 904120984,
///             "email": "hilda.johnson@example.com",
///             "gender": "female",
///             "location": {
///               "city": "brisbane",
///               "state": "tasmania",
///               "street": "6244 ranchview dr",
///               "zip": 70881
///             },
///             "md5": "a56dc7c4ff5f11fd7ad92b0ddfde245c",
///             "name": {
///               "first": "hilda",
///               "last": "johnson",
///               "title": "miss"
///             },
///             "password": "sheena",
///             "phone": "05-8738-0745",
///             "picture": {
///               "large": "https://randomuser.me/api/portraits/women/10.jpg",
///               "medium": "https://randomuser.me/api/portraits/med/women/10.jpg",
///               "thumbnail": "https://randomuser.me/api/portraits/thumb/women/10.jpg"
///             },
///             "registered": 1084406587,
///             "salt": "CGFF030d",
///             "sha1": "05fd4d6ed75c7cd92e2056f085372d468feefb3a",
///             "sha256": "8f2b67507559851824817ea73ae50899505d495ca113cd336d8b06bae4ebf826",
///             "username": "greenswan671"
///           }
///         }
///       ],
///       "seed": "fdf3e44db843b3b000",
///       "version": "0.7"
///     }
///
/// Avoids adding an empty query when sending the request.
public class RandomUser {

  static let url = URL(string: "https://randomuser.me/api/")!

  public var results: Int?

  public var gender: String?

  public var seed: String?

  public var nat: String?

  /// Uses the shared URL session to generate random user information.
  /// - parameter handler: Escaping capture that accepts a dictionary containing
  ///   random-user results.
  public func get(handler: @escaping (NSDictionary) -> Void) {
    let session = URLSession.shared
    var urlComponents = URLComponents(url: RandomUser.url, resolvingAgainstBaseURL: false)!
    var queryItems = [URLQueryItem]()
    if let results = results {
      queryItems.append(URLQueryItem(name: "results", value: String(results)))
    }
    if let gender = gender {
      queryItems.append(URLQueryItem(name: "gender", value: gender))
    }
    if let seed = seed {
      queryItems.append(URLQueryItem(name: "seed", value: seed))
    }
    if let nat = nat {
      queryItems.append(URLQueryItem(name: "nat", value: nat))
    }
    if queryItems.count > 0 {
      urlComponents.queryItems = queryItems
    }
    let task = session.dataTask(with: urlComponents.url!) { data, response, error in
      guard let data = data else {
        return
      }
      guard let object = try? JSONSerialization.jsonObject(with: data, options: []) else {
        return
      }
      guard let dictionary = object as? NSDictionary else {
        return
      }
      handler(dictionary)
    }
    task.resume()
  }

  /// Initialises a random-user connection.
  public init() {}

}
