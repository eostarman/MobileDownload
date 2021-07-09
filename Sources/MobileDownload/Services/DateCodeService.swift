//
//  DateCodeService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 10/23/20.
//

import Foundation

public struct DateCodeService {
    private let monthMapContiguous = Array("ABCDEFGHIJKL") // A=1 L=12
    private let monthMapSkippingI = Array("ABCDEFGHJKLM") // A=1 M=12
    private let monthMapSkippingIJ = Array("ABCDEFGHKLMN") // A=1 N=12
    private let monthMapForAnchor = Array("JFMAYULGSOND") // Jan Feb Mar Apr maY jUn juL auG Sep Oct Nov Dec

    private let yearMapContiguous = Array("ABCDEFGHIJ") // A=1 J=0
    private let yearMapSkippingJ = Array("ABCDEFGHIK") // A=1 K=0

    private let dayMapForAnchor = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ78901") // A-Z ==> 1-26; 7=27 8=28 9=29 0=30 1=31

    private var monthMap: [Character]?
    private var yearMap: [Character]?
    private var dayMap: [Character]?

    private var strictLength = false

    private var startingYearLetter: Character?
    private var startingYearForLetter: Int?

    private let patterns: [String]

    private func getInteger(_ chars: [Character]) -> Int? {
        let number = String(chars)
        return Int(number)
    }

    private func getIntegerFromMap(char: Character, map: [Character]) -> Int? {
        for (i, chr) in map.enumerated() {
            if chr == char {
                return i
            }
        }
        return nil
    }

    private func isSellByDateInTheFuture(sellByMonth: Int, thisMonth: Int) -> Bool? {
        if sellByMonth == thisMonth {
            return true
        }

        func getMonth(_ inputMonth: Int) -> Int {
            var month = inputMonth

            while month < 1 {
                month += 12
            }
            while month > 12 {
                month -= 12
            }
            return month
        }

        for offset in 1 ... 6 {
            if sellByMonth == getMonth(thisMonth + offset) {
                return true
            }
            if sellByMonth == getMonth(thisMonth - offset) {
                return false
            }
        }

        return nil // assuming sellByMonth is 1 ... 12 and thisMonth is 1 ... 12, the above code must return (but, maybe sellByMonth is bad - e.g. 99)
    }

    private func getMonth(_ month: [Character]) -> Int? {
        if month.count == 3 { // "jan", "feb", "mar", ...
            let thisMonthName = String(month)

            for (i, monthName) in Calendar.current.shortMonthSymbols.enumerated() {
                if thisMonthName.localizedCaseInsensitiveCompare(monthName) == .orderedSame {
                    return i + 1
                }
            }
        }

        if month.count == 1 {
            if let months = monthMap, let monthCharacter = month.first {
                if let n = getIntegerFromMap(char: monthCharacter, map: months) {
                    return n + 1
                }
            }

            return nil
        }

        return getInteger(month)
    }

    private func getDay(_ dayField: [Character]) -> Int? {
        if dayField.count == 1 {
            if let days = dayMap, let dayCharacter = dayField.first {
                if let n = getIntegerFromMap(char: dayCharacter, map: days) {
                    return n + 1
                }
                return nil
            }
        }

        return Int(String(dayField))
    }

    private func getYearInCurrentCentury(year: Int) -> Int {
        if year <= 99 {
            let century = Calendar.current.component(.year, from: today) / 100
            return century * 100 + year
        } else {
            return year
        }
    }

    private func getYearForSingleDigitYear(lastDigitOfTheYear: Int) -> Int? {
        let currentYear = Calendar.current.component(.year, from: today)

        // look at 10 years (current year - 4 through current year + 5). Check the current year, then the next year, then the prior year, ...
        for offset in [0, 1, -1, 2, -2, 3, -3, 4, -4, 5] {
            if (currentYear + offset) % 10 == lastDigitOfTheYear {
                return currentYear + offset
            }
        }

        return nil // mpr: this isn't mathematically possible if lastDigitOfTheYear is 0 ... 9
    }

    private func getYearFromSpecialLetter(startingYearLetter: Character, startingYearForLetter: Int, yearLetter: Character) -> Int? {
        func getLetterOffset(letter: Character) -> Int? {
            guard let a = Character("A").asciiValue, let x = Character(letter.uppercased()).asciiValue else { return nil }
            let offset = Int(x) - Int(a) // need to convert from UInt8 or we can get an overflow error
            return offset
        }

        guard let startLetter = getLetterOffset(letter: startingYearLetter), var thisLetter = getLetterOffset(letter: yearLetter) else { return nil }

        if thisLetter < startLetter {
            thisLetter += 26
        }

        let year = startingYearForLetter + thisLetter - startLetter

        return year
    }

    private func getYear(_ yearField: [Character]) -> Int? {
        if let mapLettersToDigits = yearMap {
            var year = 0

            for chr in yearField {
                guard let digit = getIntegerFromMap(char: chr, map: mapLettersToDigits) else { return nil }
                year = year * 10 + (digit + 1) % 10
            }

            return getYearInCurrentCentury(year: year)
        }

        if let startingYearLetter = startingYearLetter, let startingYearForLetter = startingYearForLetter, let yearLetter = yearField.first {
            return getYearFromSpecialLetter(startingYearLetter: startingYearLetter, startingYearForLetter: startingYearForLetter, yearLetter: yearLetter)
        }

        if let year = getInteger(yearField) {
            if yearField.count == 1 {
                return getYearForSingleDigitYear(lastDigitOfTheYear: year)
            }
            return getYearInCurrentCentury(year: year)
        }

        return nil
    }

    private let labelFormat: eDateCodeLabelFormat
    private let dateCodeIsSellByDate: Bool
    private let today: Date

    public init(_ labelFormat: eDateCodeLabelFormat, dateCodeIsSellByDate: Bool, today: Date? = nil) {
        self.labelFormat = labelFormat
        self.dateCodeIsSellByDate = dateCodeIsSellByDate
        self.today = today ?? Date()

        switch labelFormat {
        case .None:
            patterns = []

        case .MMddy_XXXXXX_XXX:
            patterns = ["MMddy_XXXXXX_XXX"]

        case .MMddy:
            patterns = ["MMddy"]

        case .Mddy:
            patterns = ["Mddy"]
            monthMap = monthMapContiguous

        case .yddd_XXXX:
            patterns = ["yddd_XXXX"]

        case .St_Pauli_Girl:
            patterns = ["XXXX_X_XX_X_ddd.y", "XXXX_XXXX_X_XX_X_ddd.y", "ddd.y"]
            strictLength = true

        case .MMddyy:
            //patterns = ["MMddyy"]
            patterns = ["MMddyy", "ddMMyy"] //TODO: remove this - it's for testing the entry of a date code that's ambiguous

        case .Tsingtao:
            patterns = ["XXXMMddyyyy/hh:mm", "MMddyyyy/hh:mm", "MMddyyyy", "XXXMMddyyyy", "MMddyy"]
            strictLength = true

        case .Mddyy_Skip_I:
            patterns = ["Mddyy"]
            monthMap = monthMapSkippingI

        case .dddy:
            patterns = ["dddy"]

        case .MM_dd_yy:
            patterns = ["MM_dd_yy"]

        case .ddd_yy:
            patterns = ["ddd_yy"]

        case .MM_yy:
            patterns = ["MM_yy"]

        case .dd_MM_y_Letter_Year_X_2012:
            patterns = ["dd_MM_y"]
            startingYearLetter = "X"
            startingYearForLetter = 2012

        case .yyMdd:
            patterns = ["yyMdd"]
            monthMap = monthMapContiguous

        case .yMMddXXX:
            patterns = ["yMMddXXX"]

        case .Pyramid_Brewing:
            patterns = ["MMddyy", "yddd"]
            strictLength = true

        case .yddd:
            patterns = ["yddd"]

        case .yyddd:
            patterns = ["yyddd"]

        case .MMMddyy:
            patterns = ["MMMddyy", "MMddyy"]

        case .dddyy:
            patterns = ["dddyy"]

        case .ddMMMyy:
            patterns = ["ddMMMyy", "ddMMyy"]

        case .ddMMMyyyy:
            patterns = ["ddMMMyyyy", "ddMMyyyy"]

        case .ddMMy_Letter_Year_X_2013:
            patterns = ["ddMMy"]
            startingYearLetter = "X"
            startingYearForLetter = 2013

        case .ddMMyy:
            patterns = ["ddMMyy"]

        case .ddMy_Skip_I:
            patterns = ["ddMy"]
            monthMap = monthMapSkippingI

        case .MMddyyyy:
            patterns = ["MMddyyyy"]

        case .MMMddyyyy:
            patterns = ["MMMddyyyy", "MMddyyyy"]

        case .MMyy:
            patterns = ["MMyy"]

        case .yyMMdd:
            patterns = ["yyMMdd"]

        case .yyyyMMdd:
            patterns = ["yyyyMMdd"]

        case .MMyyyy:
            patterns = ["MMyyyy"]

        case .MMdd:
            patterns = ["MMdd"]

        case .ddMyy_Skip_IJ:
            patterns = ["ddMyy"]
            monthMap = monthMapSkippingIJ

        case .MMMdd:
            patterns = ["MMMdd", "MMdd"]

        case .MMyyyydd:
            patterns = ["MMyyyydd"]

        case .dd_MM_yyyy:
            patterns = ["dd_MM_yyyy"]

        case .Mddyy:
            patterns = ["Mddyy"]
            monthMap = monthMapContiguous

        case .MMMyy:
            patterns = ["MMMyy", "MMyy"]

        case .ddd:
            patterns = ["ddd"]

        case .Mddy_Skip_I:
            patterns = ["Mddy"]
            monthMap = monthMapSkippingI

        case .Anchor:
            patterns = ["yMd"]
            strictLength = true
            dayMap = dayMapForAnchor
            monthMap = monthMapForAnchor

        case .ddMyy_Skip_I:
            patterns = ["ddMyy"]
            monthMap = monthMapSkippingI

        case .ddMMy_Letter_Year_E_2015:
            patterns = ["ddMMy"]
            startingYearLetter = "E"
            startingYearForLetter = 2015

        case .Myydd:
            patterns = ["Myydd"]
            monthMap = monthMapContiguous

        case .MMMyyyy:
            patterns = ["MMMyyyy", "MMyyyy"]

        case .yyddd_Letter_Year:
            patterns = ["yyddd"]
            yearMap = yearMapContiguous

        case .yddd_Letter_Year_Skip_J:
            patterns = ["yddd"]
            yearMap = yearMapSkippingJ

        case .ddMMyyyy:
            patterns = ["ddMMyyyy"]
        }
    }
    
    public var hasDateCode: Bool {
        !patterns.isEmpty
    }

    public func getDescription() -> String {
        if patterns.isEmpty {
            return "no date code"
        }
        
        var formats: [String] = []
        
        for pattern in patterns {
            formats.append(pattern.replacingOccurrences(of: "_", with: " "))
        }
        
        // https://developer.apple.com/documentation/foundation/listformatstyle
        return formats.formatted(.list(type: .or, width: .standard)) // return "MMDDYY or YYMMDD" for example
    }

    public func getDateCode(_ textString: String) -> [DateCode] {
        var dateCodes: [DateCode] = []
        
        for pattern in patterns {
            if let dateCode = getDateCode(pattern: pattern, text: textString) {
                dateCodes.append(dateCode)
            }
        }

        return dateCodes
    }

    private func getDateCode(pattern: String, text textString: String) -> DateCode? {
        var dayField = [Character]()
        var monthField = [Character]()
        var yearField = [Character]()
        var hourField = [Character]()
        var minuteField = [Character]()
        var secondField = [Character]()

        let text = Array(textString)

        if strictLength && pattern.count != text.count {
            return nil
        }

        for (i, patternCharacter) in pattern.enumerated() {
            let textCharacter = i < text.count ? text[i] : " "

            switch patternCharacter {
            case "d":
                dayField.append(textCharacter)
            case "M":
                monthField.append(textCharacter)
            case "y":
                yearField.append(textCharacter)
            case "h":
                hourField.append(textCharacter)
            case "m":
                minuteField.append(textCharacter)
            case "s":
                secondField.append(textCharacter)
            default:
                break
            }
        }

        var year = getYear(yearField)
        var month = getMonth(monthField)
        var day = getDay(dayField)
        let hour = getInteger(hourField)
        let minute = getInteger(minuteField)
        let second = getInteger(secondField)

        if dayField.count > 0 && day == nil ||
            monthField.count > 0 && month == nil ||
            yearField.count > 0 && year == nil ||
            hourField.count > 0 && hour == nil ||
            minuteField.count > 0 && minute == nil ||
            secondField.count > 0 && second == nil
        {
            return nil
        }

        // when a year isn't specified then use this year
        if yearField.isEmpty, !monthField.isEmpty, !dayField.isEmpty {
            let components = Calendar.current.dateComponents([.day, .month, .year], from: today)
            guard let thisDay = components.day else { return nil }
            guard let thisMonth = components.month else { return nil }
            guard let thisYear = components.year else { return nil }

            if let day = day, let month = month {
                if dateCodeIsSellByDate {
                    // this code is making a best-guess here: is the sell-by date in the future or is it in the past
                    // If it's October and the sell-by is August, then it's in the past; if the sell-by is January then that's next January
                    guard let isFuture = isSellByDateInTheFuture(sellByMonth: month, thisMonth: thisMonth) else { return nil }

                    if isFuture, month < thisMonth { // e.g. it's November, and the sell-by date is January (that must be next year)
                        year = thisYear + 1
                    } else if !isFuture, month > thisMonth { // e.g. it's January and the sell-by date is November (that must be last year)
                        year = thisYear - 1
                    } else { // e.g. it's March and the sell-by date is May
                        year = thisYear
                    }
                } else {
                    // if the date code is a "born-on" date (or a "packaged-on date"), then it cannot be in the future. So, if it's November and
                    // the date code is December, then it must be December of last year (not this year)
                    let dateIsOnOrBeforeToday = month < thisMonth || (month == thisMonth && day <= thisDay)

                    year = dateIsOnOrBeforeToday ? thisYear : thisYear - 1
                }
            }
        }

        if dayField.count == 3 { // handle a julian day (1=Jan1, ... 365=Dec31 for a non-leap-year - otherwise 366=Dec31) within the current year
            guard let date = Calendar.current.date(from: DateComponents(year: year, day: day)) else {
                return nil
            }

            month = Calendar.current.component(.month, from: date)
            day = Calendar.current.component(.day, from: date)
        }

        let dateCode = DateCode(labelFormat: labelFormat, pattern: pattern, dateCodeIsSellByDate: dateCodeIsSellByDate, year: year, month: month, day: day, hour: hour, minute: minute, second: second)

        return dateCode
    }
}
