//
//  UPC.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 10/18/20.
//  from UPC.cs
//

import Foundation

public struct UPC {
    public var isValid: Bool { countryCode >= 0 && manufacturerCode >= 0 && productCode >= 0 }
    public let countryCode: Int
    public let manufacturerCode: Int
    public let productCode: Int

    public static func getEAN13(_ upcText: String, withSpaces: Bool) -> String? {
        let upc = UPC(upcText)
        let ean13 = upc.getEAN13(withSpaces: withSpaces)
        return ean13
    }

    // https://www.gs1.org/services/how-calculate-check-digit-manually
    private func getCheckDigit(upcText: String) -> String? {
        var sum = 0
        for (i, chr) in upcText.enumerated() {
            guard let digit = chr.wholeNumberValue else { return nil }
            let isOdd = (i + 1) % 2 == 1

            sum += digit * (isOdd ? 1 : 3)
        }

        let nextMultipleOfTen = ((sum + 9) / 10) * 10

        let checkDigit = nextMultipleOfTen - sum
        return String(checkDigit)
    }

    public func getEAN13(withSpaces: Bool) -> String? {
        if !isValid {
            return nil
        }
        let country = String(format: "%02d", countryCode)
        let manufacturer = String(format: "%05d", manufacturerCode)
        let product = String(format: "%05d", productCode)

        guard let checkDigit = getCheckDigit(upcText: country + manufacturer + product) else { return nil }

        let ean13: String

        if withSpaces {
            ean13 = country + " " + manufacturer + " " + product + " " + checkDigit
        } else {
            ean13 = country + manufacturer + product + checkDigit
        }
        return ean13
    }

    public init(_ upcText: String) {
        if upcText.isEmpty {
            countryCode = -1
            manufacturerCode = 0
            productCode = 0
            return
        }

        var upc = Array(upcText)

        func GetInt(_ from: Int, _ length: Int) -> Int {
            var n = 0

            for i in from ..< from + length {
                if let digit = upc[i].wholeNumberValue {
                    n = n * 10 + digit
                } else {
                    return -1 // a non-digit
                }
            }

            return n
        }

        switch upc.count {
        case 14: // EAN-13 - http://www.codeproject.com/Articles/10162/Creating-EAN-13-Barcodes-with-C
            countryCode = GetInt(0, 3)
            manufacturerCode = GetInt(3, 5)
            productCode = GetInt(8, 5)
        // CheckSum = GetInt(upc, 13, 1)
        case 13: // EAN-13 - http://www.codeproject.com/Articles/10162/Creating-EAN-13-Barcodes-with-C
            countryCode = GetInt(0, 2)
            manufacturerCode = GetInt(2, 5)
            productCode = GetInt(7, 5)
        // CheckSum = GetInt(12, 1)
        case 12: // UPC-A
            countryCode = GetInt(0, 1)
            manufacturerCode = GetInt(1, 5)
            productCode = GetInt(6, 5)
        // CheckSum = GetInt(11, 1)
        case 11: // UPC-A without the check digit
            countryCode = GetInt(0, 1)
            manufacturerCode = GetInt(1, 5)
            productCode = GetInt(6, 5)
        case 10: // UPC without the country code or check digits (assumption)
            countryCode = 0
            manufacturerCode = GetInt(0, 5)
            productCode = GetInt(5, 5)
        case 6: fallthrough // UPC-E (zero-suppressed)
        case 8: // UPC-E with (I presume) check-digits

            if upc.count == 8 {
                upc = Array(upc[1 ... 6]) // presume a 6-digit UPC-E with "check digits"
            }

            switch upc[5] {
            case "0": fallthrough // XXNNN0
            case "1": fallthrough // XXNNN1
            case "2": // XXNNN2
                let manufacturerDigits = String([upc[0], upc[1], upc[5], "0", "0"]) // left 2 digits + right digit + "00"
                countryCode = 0
                manufacturerCode = Int(manufacturerDigits) ?? 0
                productCode = GetInt(2, 3) // "00" + middle 3 digits'
            case "3": // XXXNN3
                countryCode = 0
                manufacturerCode = GetInt(0, 3) * 100
                productCode = GetInt(3, 2)
            case "4": // XXXXN4
                countryCode = 0
                manufacturerCode = GetInt(0, 4) * 10
                productCode = GetInt(4, 1)
            case "5": fallthrough
            case "6": fallthrough
            case "7": fallthrough
            case "8": fallthrough
            case "9": // XXXXX5 ... XXXXX9
                countryCode = 0
                manufacturerCode = GetInt(0, 5)
                productCode = GetInt(5, 1)
            default:
                countryCode = -1
                manufacturerCode = 0
                productCode = 0
            }

        default:
            countryCode = -1
            manufacturerCode = 0
            productCode = 0
        }
    }
}

extension UPC: Equatable {
    public static func == (lhs: UPC, rhs: UPC) -> Bool {
        if !lhs.isValid || !rhs.isValid {
            return false
        }

        return lhs.countryCode == rhs.countryCode && lhs.manufacturerCode == rhs.manufacturerCode && lhs.productCode == rhs.productCode
    }
}

// https://www.hackingwithswift.com/articles/163/how-to-use-custom-string-interpolation-in-swift
extension String.StringInterpolation {
    public mutating func appendInterpolation(_ value: UPC) {
        let manufacturerCode = String(format: "%05d", value.manufacturerCode)
        let productCode = String(format: "%05d", value.productCode)
        appendInterpolation("\(manufacturerCode)-\(productCode)")
    }
}
