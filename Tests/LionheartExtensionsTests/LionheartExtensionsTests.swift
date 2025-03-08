import Testing
import UIKit
import LionheartExtensions

struct DateFormatterLionheartExtensionsTests {
  @Test func testNoSpaceDates() async throws {
    let dates = ["2023-03-28", "2023-03-28"]
    let formatter = try DateFormatter.formatter(dateStrings: dates)
    let validFormats = [
      "MM-dd-yyyy",
      "dd-MM-yyyy",
      "yyyy-MM-dd",
      "yyyy-dd-MM",
      "yyyyMMddHHmmssZ",
    ]
    #expect(validFormats.contains(formatter.dateFormat))
    dates.forEach { #expect(formatter.date(from: $0) != nil) }
  }
  
  @Test func testWeirdOffset() throws {
    #expect("2025-03-01T09:14:00-6:00".fixedOffset() == "2025-03-01T09:14:00-06:00")
//    let dates = ["2025-03-01T09:14:00-6:00"]
//    let formatter = try DateFormatter.formatter(dateStrings: dates)
//    #expect(formatter.date(from: dates[0]) != nil)
  }
  
  @Test func testTurkishDate() throws {
    let dates = ["00:12:24 Feb 05 2025"]
    let formatter = try DateFormatter.formatter(dateStrings: dates)
    #expect(formatter.date(from: dates[0]) != nil)
  }

  @Test func testOneSpaceDates() async throws {
    let dates = ["2023-03-28 14:30", "2023-03-28 09:15"]
    let formatter = try DateFormatter.formatter(dateStrings: dates)
    dates.forEach { #expect(formatter.date(from: $0) != nil) }
  }

  @Test func testTwoSpaceDates() async throws {
    let dates = ["March 2, 2023", "April 5, 2023"]
    let formatter = try DateFormatter.formatter(dateStrings: dates)
    dates.forEach { #expect(formatter.date(from: $0) != nil) }
  }

  @Test func testInconsistentSpacingThrows() async throws {
    let dates = ["2023-03-28", "2023-03-28 14:30"]
    #expect(throws: DateFormatError.emptyDates.self) {
      try DateFormatter.formatter(dateStrings: dates)
    }
  }

  @Test func testInvalidDatesThrowsNoMatchingFormat() async throws {
    let dates = ["Invalid Date", "Another Invalid"]
    #expect(throws: DateFormatError.noMatchingFormat(nil).self) {
      try DateFormatter.formatter(dateStrings: dates)
    }
  }
}
