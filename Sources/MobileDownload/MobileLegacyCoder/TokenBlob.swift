//
//  File.swift
//
//
//  Created by Michael Rutherford on 2/13/21.
//

import Foundation
import MoneyAndExchangeRates


public class TokenBlob<T: LegacyEncodingToken> {
    let simpleNumberFormatter: NumberFormatter
    let dateFormatter: DateFormatter
    
    var blobs: [String] = []
    
    public var result: String {
        blobs.joined(separator: "\t")
    }
    
    public init() {
        simpleNumberFormatter = NumberFormatter()
        simpleNumberFormatter.groupingSeparator = ""
        simpleNumberFormatter.decimalSeparator = "."
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.locale = .current
    }
    
    func append(_ tokenType: T, _ parameters: String ...) {
        let token = tokenType.rawValue
        let blob: String
        
        if token.hasPrefix(",") {
            blob = token + "," + parameters.joined(separator: ",")
        } else {
            if token.count > 1 || parameters.count > 1 {
                fatalError("BUG: expected a single-character token followed by a single parameter")
            }
            blob = token + parameters[0]
        }
        
        blobs.append(blob)
    }
    
    public func getString(_ value: Bool) -> String {
        value ? "1" : "0" // 1==true
    }
    
    public func getString(_ value: Int?) -> String {
        guard let value = value else {
            return ""
        }
        return value.description
        //return simpleNumberFormatter.string(from: value as NSNumber)!
    }
    
    public func getString(_ value: Decimal?) -> String {
        guard let value = value else {
            return ""
        }
        let decimalNumber = value as NSDecimalNumber
        let result = decimalNumber.description(withLocale: Locale(identifier: "en_US"))
        return result
    }
    
    public func getString(_ value: MoneyWithoutCurrency?, numberOfDecimals: Int) -> String {
        guard let value = value else {
            return ""
        }
        let scaledAmount = value.scaledTo(numberOfDecimals: numberOfDecimals).scaledAmount
        return scaledAmount.description
        //return simpleNumberFormatter.string(from: scaledAmount as NSNumber)!
    }
    
    public func getString(_ value: Date?, _ format: dateFormat) -> String {
        guard let value = value else {
            return ""
        }
        
        switch format {
        case .yyyyMMdd:
            dateFormatter.dateFormat = "yyyyMMdd"
        case .yyyyMMdd_HHmmss:
            dateFormatter.dateFormat = "yyyyMMdd:HHmmss"
        case .yyyyMMdd_HHmmss_WithDashesAndColons:
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        case .yyyy_MM_dd:
            dateFormatter.dateFormat = "yyyy-MM-dd"
        
        }
        
        let result = dateFormatter.string(from: value)
        return result
    }
    
    public func addString(_ token: T, _ string: String) {
        let safeString = LegacySafeString.getsafeMobileString(string)
        append(token, safeString)
    }
    
    public func addStringIfNotEmpty(_ token: T, _ string: String?) {
        if let string = string, !string.isEmpty {
            let safeString = LegacySafeString.getsafeMobileString(string)
            append(token, safeString)
        }
    }
    
    public func addRecNidIfPositive(_ token: T, _ recNid: Int?) {
        if let recNid = recNid, recNid > 0 {
            append(token, getString(recNid))
        }
    }
    
    public func addDecimal2(_ token: T, _ value: MoneyWithoutCurrency?) {
        append(token, getString(value, numberOfDecimals: 2))
    }
    
    public func addDecimal4(_ token: T, _ value: MoneyWithoutCurrency?) {
        append(token, getString(value, numberOfDecimals: 4))
    }
    
    public func addDecimal2IfNonZero(_ token: T, _ value: MoneyWithoutCurrency?) {
        if let value = value, !value.isZero {
            append(token, getString(value, numberOfDecimals: 2))
        }
    }
    
    public func addDecimal4IfNonZero(_ token: T, _ value: MoneyWithoutCurrency?) {
        if let value = value, !value.isZero {
            append(token, getString(value, numberOfDecimals: 4))
        }
    }
    
    public func addBoolIfTrue(_ token: T, _ value: Bool) {
        if value {
            append(token, getString(value))
        }
    }
    
    public func addBoolIfNotNull(_ token: T, _ value: Bool) {
        if value {
            append(token, getString(value))
        }
    }
    
    public func addBool(_ token: T, _ value: Bool) {
        append(token, getString(value))
    }
    
    public func addInt(_ token: T, _ value: Int?) {
        append(token, getString(value))
    }
    
    public func addIntIfNotNull(_ token: T, _ value: Int?) {
        if let number = value {
            append(token, getString(number))
        }
    }
    
    public func addDateTime(_ token: T, _ value: Date) {
        append(token, getString(value, .yyyyMMdd_HHmmss_WithDashesAndColons))
    }
    
    public func addDateIfNotNull(_ token: T, _ value: Date?, _ format: dateFormat) {
        if let date = value {
            append(token, getString(date, format))
        }
    }
    
    public func addMoneyAsDecimal(_ token: T, _ value: MoneyWithoutCurrency) {
        append(token, getString(value.decimalValue))
    }
    
    public func addMoneyAsDecimalIfNotNull(_ token: T, _ value: MoneyWithoutCurrency?) {
        if let amount = value {
            append(token, getString(amount.decimalValue))
        }
    }
    
    public func addStringIfNotNull(_ token: T, _ value: String?) {
        if let value = value {
            append(token, value)
        }
    }
    
    public func addDateAndEmpNidIfDateIsNotNull(_ token: T, _ date: Date?, _ empNid: Int?, _ format: dateFormat) {
      
        if let date = date {
            if empNid == nil {
                // empNid (1) is the eoStar admin - I'm not expecting nil, but if I upload the date without the empNid, the eonetservice parser will fail
                print("ERROR: had to change the empNid from nil to (1) for \(token)")
            }
            append(token, getString(date, format), getString(empNid ?? 1))
        }
    }
    
}

public enum dateFormat {
    case yyyy_MM_dd
    case yyyyMMdd
    case yyyyMMdd_HHmmss
    case yyyyMMdd_HHmmss_WithDashesAndColons
}

