//
//  DateFormatter+LionheartExtensions.swift
//  Pods
//
//  Created by Daniel Loewenherz on 9/2/17.
//
//

import Foundation

public struct NoMatchingFormat: Equatable, Sendable {
  public var input: String
  public var format: String

  public static func == (lhs: NoMatchingFormat, rhs: NoMatchingFormat) -> Bool {
    return lhs.input == rhs.input && lhs.format == rhs.format
  }

  public init(input: String, format: String) {
    self.input = input
    self.format = format
  }
}

public enum DateFormatError: Error, Equatable {
  case emptyDates
  case inconsistentFormat
  case unspecified
  case noMatchingFormat(NoMatchingFormat?)

  public static func == (lhs: DateFormatError, rhs: DateFormatError) -> Bool {
    switch (lhs, rhs) {
    case (.emptyDates, .emptyDates):
      return true
    case (.inconsistentFormat, .inconsistentFormat):
      return true
    case (.unspecified, .unspecified):
      return true
    case (.noMatchingFormat(let lhsValue), .noMatchingFormat(let rhsValue)):
      return lhsValue == rhsValue
    default:
      return false
    }
  }
}

private struct DateFormatterString {
  static let DateComponent1 = "MM-dd-yyyy"
  static let DateComponent2 = "dd-MM-yyyy"
  static let DateComponent3 = "yyyy-MM-dd"
  static let DateComponent4 = "yyyy-dd-MM"
  static let DateComponent5 = "yyyyMMddHHmmssZ"
  static let DateComponent6 = "MMMM d, yyyy"
  static let DateComponent7 = "MMM dd yyyy"

  static let TimeComponent1 = "HH:mm"
  static let TimeComponent2 = "hh:mm a"
  static let TimeComponent3 = "HH:mm:ss"
  static let TimeComponent4 = "hh:mm:ss a"
  static let TimeComponent5 = "HH:mm:ss Z"
  static let TimeComponent6 = "hh:mm:ss a Z"
  static let TimeComponent7 = "HH:mm:ssZ"
  static let TimeComponent8 = "HH:mm:ss.SSSZ"
  static let TimeComponent9 = "HH:mm:ssZZZZZ"

  // Take one of the following
  static let ZeroSpaceDateStrings = [
    DateComponent1, DateComponent2, DateComponent3, DateComponent4,
    DateComponent5,
  ]
  static let TwoSpaceDateStrings = [DateComponent6, DateComponent7]

  // And mix with one of these
  static let ZeroSpaceTimeStrings = [
    TimeComponent1, TimeComponent3, TimeComponent7, TimeComponent8,
    TimeComponent9,
  ]

  static let OneSpaceTimeStrings = [
    TimeComponent2, TimeComponent4, TimeComponent5,
  ]
  static let TwoSpaceTimeStrings = [TimeComponent6]
}

nonisolated(unsafe) let badOffset = /-(\d:\d\d)/

extension String {
  public func fixedOffset() -> String {
    replacing(badOffset, with: { "-0\($0.output.1)" })
  }
}

extension DateFormatter {
  private convenience init(format: String) {
    self.init()
    locale = Locale(identifier: "en_US_POSIX")

    // Without setting the timezone and locale, dates like "2023-03-12T02:10:00" will fail to parse.
    // 2am on March 12 is not a valid time!
    timeZone = TimeZone(secondsFromGMT: 0)
    dateFormat = format
  }

  /// Returns a `DateFormatter` that handles all of the provided `dateStrings`, or `nil` if a formatter could not be found.
  public static func formatter(dateStrings: [String]) throws -> DateFormatter {
    var numberOfSpaces: Int?
    for dateString in dateStrings {
      let characters: [Character] = dateString.filter({ $0 == " " || $0 == "T" }
      )
      let count = characters.count

      // If the number of spaces between date strings is inconsistent, there's no way we can find a formatter to match all of them.
      if let numberOfSpaces = numberOfSpaces, count != numberOfSpaces {
        throw DateFormatError.emptyDates
      }

      numberOfSpaces = count
    }

    // This will never happen, but we need to make numberOfSpaces an optional so we can compare it to count above.
    guard let numberOfSpaces else {
      throw DateFormatError.unspecified
    }

    var formatters: [DateFormatter] = []
    if numberOfSpaces == 0 {
      formatters = DateFormatterString.ZeroSpaceDateStrings.map {
        DateFormatter(format: $0)
      }
    } else {
      let timeFormatStrings: [String]
      switch numberOfSpaces {
      case 1: timeFormatStrings = DateFormatterString.ZeroSpaceTimeStrings
      case 2:
        timeFormatStrings = DateFormatterString.OneSpaceTimeStrings
        formatters.append(contentsOf: [
          DateFormatter(format: DateFormatterString.DateComponent6),
          DateFormatter(format: DateFormatterString.DateComponent7),
        ])

      case 3:
        timeFormatStrings = DateFormatterString.TwoSpaceTimeStrings
        formatters.append(contentsOf: [
          // "00:12:24 Feb 05 2025"
          DateFormatter(
            format:
              "\(DateFormatterString.TimeComponent3) \(DateFormatterString.DateComponent7)"
          )
        ])
      default: throw DateFormatError.noMatchingFormat(nil)
      }

      for dateString in DateFormatterString.ZeroSpaceDateStrings {
        formatters.append(DateFormatter(format: dateString))

        for timeString in timeFormatStrings {
          formatters.append(
            DateFormatter(format: "\(dateString) \(timeString)"))
          formatters.append(
            DateFormatter(format: "\(dateString)'T'\(timeString)"))
        }
      }
    }

    var noMatchingFormat: NoMatchingFormat? = nil
    formatterLoop: for formatter in formatters {
      var i = 0
      for var dateString in dateStrings {
        dateString = dateString.fixedOffset()
        guard formatter.date(from: dateString) != nil else {
          // Skip to the next formatter if a string failed to parse with this formatter.
          if i > (dateStrings.count / 2) {
            noMatchingFormat = NoMatchingFormat(
              input: dateString, format: formatter.dateFormat)
          }

          continue formatterLoop
        }

        i += 1
      }

      // If we got here, all of the strings worked with this formatter.
      return formatter
    }

    // No date formatter worked for everything. Fail.
    throw DateFormatError.noMatchingFormat(noMatchingFormat)
  }
}
