//
//  DateExtensions.swift
//  MobileBench
//
//  Created by Michael Rutherford on 7/15/20.
//

import Foundation

public extension Date {
    static let yyyyMMdd: DateFormatter = getDateFormatter(format: "yyyyMMdd") // 20200529
    static let yyyy_mm_dd: DateFormatter = getDateFormatter(format: "yyyy-MM-dd")

    static let yyyy_MM_dd_T_HH_mm_ss: DateFormatter = getDateFormatter(format: "yyyy-MM-dd'T'HH:mm:ss") // 2020-05-29T20:05:45.3348731-04:00
    static let yyyyMMdd_HHmmss: DateFormatter = getDateFormatter(format: "yyyyMMdd:HHmmss") // 20200529:200545
    static let yyyy_MM_dd_space_HH_mm_ss: DateFormatter = getDateFormatter(format: "yyyy-MM-dd HH:mm:ss") // 2020-05-29 20:05:45

    private static var formattersByFormatString: [String: DateFormatter] = [:]

    private static func getDateFormatter(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .iso8601)
        // formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }

    /// A cache of dates (as strings)  converted to actual Date objects; this is a very expensive operation without the cache. Don't cache Date/Time strings though
    private static var cachedDates: [String: Date?] = [:]

    static func fromyyyyMMdd(_ yyyyMMdd: String) -> Date? {
        fromDownloadedDate(yyyyMMdd)
    }

    static func fromyyyyMMdd(_ yyyyMMdd: Int) -> Date? {
        fromDownloadedDate(String(yyyyMMdd))
    }

    static func fromDownloadedDate(_ string: String) -> Date? {
        if string.isEmpty {
            return nil
        }

        if let cachedDate = cachedDates[string] {
            return cachedDate
        }

        let length = string.count

        let date: Date?

        if length == 8 {
            date = yyyyMMdd.date(from: string)
        } else if length == 10 {
            date = yyyy_mm_dd.date(from: string)
        } else {
            return nil
        }

        cachedDates[string] = date
        return date
    }

    static func fromDownloadedDateTime(_ string: String) -> Date? {
        if string.isEmpty {
            return nil
        }

        let length = string.count

        if length > 19 {
            let stringWithoutMicrosecondsAndTimezone = String(string.prefix(19))
            return yyyy_MM_dd_T_HH_mm_ss.date(from: stringWithoutMicrosecondsAndTimezone)
        } else if length == 19 {
            if string.contains(" ") {
                return yyyy_MM_dd_space_HH_mm_ss.date(from: string)
            } else {
                return yyyy_MM_dd_T_HH_mm_ss.date(from: string)
            }
        } else if length == 15 {
            return yyyyMMdd_HHmmss.date(from: string)
        } else {
            return nil
        }
    }

    static func fromDownloadedDateOrDateTime(_ string: String) -> Date? {
        if string.isEmpty {
            return nil
        }

        if let datetime = fromDownloadedDateTime(string) {
            return datetime
        }

        if let date = fromDownloadedDate(string) {
            return date
        }

        return nil
    }

    func toLocalTimeDescription() -> String {
        let string = Date.yyyy_MM_dd_space_HH_mm_ss.string(from: self)
        return string
    }

    func toLocalTime_yyyyMMdd() -> String {
        let string = Date.yyyyMMdd.string(from: self)
        return string
    }

    func description(withFormat format: String = "MM/dd/yyyy") -> String {
        if let formatter = Date.formattersByFormatString[format] {
            return formatter.string(from: self)
        }

        let newFormatter = Date.getDateFormatter(format: format)
        Date.formattersByFormatString[format] = newFormatter
        return newFormatter.string(from: self)
    }

    func withoutTimeStamp() -> Date {
        let dateOnly = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!

        return dateOnly
    }

    func asRelativeDateIfPossible() -> String {
        if #available(iOS 13.0, *) {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full

            let relativeDate = formatter.localizedString(for: self, relativeTo: Date())
            return relativeDate
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            let absoluteDate = dateFormatter.string(from: self)
            return absoluteDate
        }
    }
}
