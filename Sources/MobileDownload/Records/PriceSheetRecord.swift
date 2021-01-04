import Foundation
import MoneyAndExchangeRates

public final class PriceSheetRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var priceBookNid: Int = 0
    public var startDate: Date = .distantPast
    public var endDate: Date?
    public var perCategoryMinimums: Bool = false
    public var perItemMinimums: Bool = false
    public var perPriceSheetMinimums: Bool = false

    public var endDateIsSupercededDate: Bool = false
    public var isDepositSchedule: Bool = false

    public var columInfos: [Int: ColumnInfo] = [:]

    public var warehouses: [Int: PriceLevel] = [:]
    public var customers: [Int: PriceLevel] = [:]

    public var prices: [Int: [Int: MoneyWithoutCurrency]] = [:] // prices[itemNid][column] -> price

    public var priceBookName: String = ""
    public var currency: Currency = .USD

    public init() { }

    public struct ColumnInfo: Codable {
        public var columnNotes: String = ""
        public var isAutoColumn: Bool = false
        public var columnMinimum: Int = 0
        public var isCaseMinimum: Bool = false
        public var isMoneyMinimum: Bool = false
        public var isWeightMinimum: Bool = false
        public var basisIndex: Int = 0

        public init() { }
    }

    public struct PriceLevel: Codable {
        public let priceLevel: Int
        public let canUseAutomaticColumns: Bool

        public init(priceLevel: Int, canUseAutomaticColumns: Bool) {
            self.priceLevel = priceLevel
            self.canUseAutomaticColumns = canUseAutomaticColumns
        }
    }

    /// Set the price of an item in a price column. Note that the price sheet has an assigned currency, so this takes the price without the currency
    public func setPrice(itemNid: Int, priceLevel: Int, price: MoneyWithoutCurrency) {
        if var pricesByColumn = prices[itemNid] {
            pricesByColumn[priceLevel] = price
        } else {
            var newColumnPrices: [Int: MoneyWithoutCurrency] = [:]
            newColumnPrices[priceLevel] = price
            prices[itemNid] = newColumnPrices
        }
    }

    public func getPrice(itemNid: Int, priceLevel: Int) ->  Money? {
        prices[itemNid]?[priceLevel]?.withCurrency(currency)
    }

    public func isActive(on date: Date) -> Bool {
        if date < startDate {
            return false
        }

        guard let endDate = endDate else {
            return true
        }

        if endDateIsSupercededDate {
            if date >= endDate { // this price sheet was superceded *on* the given endDate by a different price sheet
                return false
            }
        } else {
            if date > endDate {
                return false
            }
        }

        return true
    }
}
