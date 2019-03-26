//
//  DateFormatter+LionheartExtensions.swift
//  Pods
//
//  Created by Daniel Loewenherz on 9/2/17.
//
//

import Foundation

public enum DateFormatError: Error {
    case emptyDates
    case inconsistentFormat
    case unspecified
    case noMatchingFormat
}

fileprivate struct DateFormatterString {
    static let DateComponent1 = "MM-dd-yyyy"
    static let DateComponent2 = "dd-MM-yyyy"
    static let DateComponent3 = "yyyy-MM-dd"
    static let DateComponent4 = "yyyy-dd-MM"
    static let DateComponent5 = "yyyyMMddHHmmssZ"
    static let DateComponent6 = "MMMM d, yyyy"
    
    static let TimeComponent1 = "HH:mm"
    static let TimeComponent2 = "hh:mm a"
    static let TimeComponent3 = "HH:mm:ss"
    static let TimeComponent4 = "hh:mm:ss a"
    static let TimeComponent5 = "HH:mm:ss Z"
    static let TimeComponent6 = "hh:mm:ss a Z"
    static let TimeComponent7 = "HH:mm:ssZ"
    static let TimeComponent8 = "HH:mm:ss.SSSZ"
    
    // Take one of the following
    static let NoSpaceFormatStrings = [DateComponent1, DateComponent2, DateComponent3, DateComponent4, DateComponent5]
    
    // And mix with one of these
    static let OneSpaceFormatStrings = [TimeComponent1, TimeComponent3, TimeComponent7, TimeComponent8]
    static let TwoSpaceFormatStrings = [TimeComponent2, TimeComponent4, TimeComponent5]
    static let ThreeSpaceFormatStrings = [TimeComponent6]
}

public extension DateFormatter {
    private convenience init(format: String) {
        self.init()
        locale = Locale(identifier: "en_US_POSIX")
        dateFormat = format
    }
    
    /// Returns a `DateFormatter` that handles all of the provided `dateStrings`, or `nil` if a formatter could not be found.
    static func formatter(dateStrings: [String]) throws -> DateFormatter {
        var numberOfSpaces: Int?
        for dateString in dateStrings {
            let characters: [Character] = dateString.filter({ $0 == " " || $0 == "T" })
            let count = characters.count
            
            // If the number of spaces between date strings is inconsistent, there's no way we can find a formatter to match all of them.
            if let numberOfSpaces = numberOfSpaces, count != numberOfSpaces {
                throw DateFormatError.emptyDates
            }
            
            numberOfSpaces = count
        }

        // This will never happen, but we need to make numberOfSpaces an optional so we can compare it to count above.
        guard let _numberOfSpaces = numberOfSpaces else {
            throw DateFormatError.unspecified
        }
        
        var formatters: [DateFormatter] = []
        if _numberOfSpaces == 0 {
            formatters = DateFormatterString.NoSpaceFormatStrings.map { DateFormatter(format: $0) }
        } else {
            let timeFormatStrings: [String]
            switch _numberOfSpaces {
            case 1: timeFormatStrings = DateFormatterString.OneSpaceFormatStrings
            case 2:
                timeFormatStrings = DateFormatterString.TwoSpaceFormatStrings
                formatters.append(DateFormatter(format: DateFormatterString.DateComponent6))
                
            case 3: timeFormatStrings = DateFormatterString.ThreeSpaceFormatStrings
            default: throw DateFormatError.noMatchingFormat
            }
            
            for dateString in DateFormatterString.NoSpaceFormatStrings {
                for timeString in timeFormatStrings {
                    formatters.append(DateFormatter(format: "\(dateString) \(timeString)"))
                    formatters.append(DateFormatter(format: "\(dateString)'T'\(timeString)"))
                }
            }
        }
        
        formatterLoop: for formatter in formatters {
            for dateString in dateStrings {
                guard formatter.date(from: dateString) != nil else {
                    // Skip to the next formatter if a string failed to parse with this formatter.
                    continue formatterLoop
                }
            }
            
            // If we got here, all of the strings worked with this formatter.
            return formatter
        }
        
        // No date formatter worked for everything. Fail.
        throw DateFormatError.noMatchingFormat
    }
}
