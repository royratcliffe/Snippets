// Snippets String+Snippets.swift
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

extension String {

  enum EncodingError: ErrorType {
    case UTF8
  }

  /// - returns: Answers an Internet socket address if the string represents a
  ///   format that converts successfully to an Internet version 4 address
  ///   *without* DNS lookup. Throws if it does not, returning an error
  ///   explaining why not. The result is a big-endian 32-bit integer. Use
  ///   `CFSwapInt32BigToHost` to access the address in a host-compatible
  ///   way. Host integers can be big- or little-endian. The operating system
  ///   knows which, and knows how to swap the bytes.
  ///
  ///   Throws `EncodingError.UTF8` if this string fails to convert to
  ///   UTF-8. Throws the POSIX domain `errno` where the `NSError` code equals
  ///   the error number if the UTF-8 encoded string fails to make an internet
  ///   address, for whatever reason.
  ///
  /// Answers positively if and only if this string successfully encodes as
  /// UTF-8 and only if BSD recognises the format. Negative response occurs also
  /// if this string fails to convert to UTF-8. In such a case, no error
  /// returns; the caller receives a `nil` address _and_ a `nil` error.
  public func toInternetAddressIPv4() throws -> in_addr {
    guard let cString = cStringUsingEncoding(NSUTF8StringEncoding) else {
      // What error to throw when this string fails to convert to a UTF-8
      // encoded character array? There does not seem to be a standard error for
      // such. Make one up. Swift makes it easy.
      throw EncodingError.UTF8
    }
    // The operating system function `inet_pton` converts an address from
    // presentation format to network format, hence p-to-n. It answers 1 for
    // valid addresses, or 0 if not parseable for the given network address
    // family.
    var internetAddress = in_addr()
    guard inet_pton(AF_INET, cString, &internetAddress) != 0 else {
      throw NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil)
    }
    return internetAddress
  }

  // same as above but for Internet version 6 addresses
  public func toInternetAddressIPv6() throws -> in6_addr {
    guard let cString = cStringUsingEncoding(NSUTF8StringEncoding) else {
      throw EncodingError.UTF8
    }
    var internetAddress = in6_addr()
    guard inet_pton(AF_INET6, cString, &internetAddress) != 0 else {
      throw NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil)
    }
    return internetAddress
  }

  public var isInternetAddressIPv4: Bool {
    return (try? toInternetAddressIPv4()) != nil
  }

  public var isInternetAddressIPv6: Bool {
    return (try? toInternetAddressIPv6()) != nil
  }

  // swiftlint:disable:next line_length
  public static let loremIpsum = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."

  /// - returns: answers the first character of the string, as a string. Answers
  ///   an empty string for empty strings.
  public var firstCharacterString: String {
    return String(characters.prefix(1))
  }

  /// - returns: answers a string where the first character is uppercase, if not
  ///   already so.
  public var uppercaseFirstCharacterString: String {
    return firstCharacterString.uppercaseString + String(characters.dropFirst())
  }

}
