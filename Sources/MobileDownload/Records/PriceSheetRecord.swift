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
    //public var perCategoryMinimums: Bool = false
    public var perItemMinimums: Bool = false            // the minimums are per-item or mix-and-match across all items in the price sheet
    //public var perPriceSheetMinimums: Bool = false

    public var endDateIsSupercededDate: Bool = false
    public var isDepositSchedule: Bool = false

    public var columInfos: [Int: ColumnInfo] = [:]

    public var warehouses: [Int: Level] = [:]
    public var customers: [Int: Level] = [:]

    public var prices: [Int: [Int: MoneyWithoutCurrency]] = [:] // prices[itemNid][column] -> price

    public var priceBookName: String = ""
    public var currency: Currency = .USD

    public init() { }

    public func getAutomaticPriceLevels() -> [Int] {
        columInfos.enumerated().filter { $0.element.value.isAutoColumn }.map { $0.element.key }
    }

    public struct ColumnInfo: Codable {

        //public var columnNotes: String = ""   // mpr: not in use anywhere in eoTouch
        public var isAutoColumn: Bool = false
        public var columnMinimum: Int = 0

        public var isCaseMinimum: Bool = false
        //public var isWeightMinimum: Bool { !isCaseMinimum }

        //public var isMoneyMinimum: Bool = false  // we stopped supporting "moneyMinimum" a long long time ago
        //public var isWeightMinimum: Bool = false // now implicit if this isn't a minimum based on cases (the default)
        //public var basisIndex: Int = 0           // not used in eoTouch (originally intended to handle things like board-feet ...)

        public init() { }

        init(columnMinimum: Int, isCaseMinimum: Bool) {
            isAutoColumn = true
            self.columnMinimum = columnMinimum
            self.isCaseMinimum = isCaseMinimum
        }
    }

    public struct Level: Codable {
        public let priceLevel: Int
        public let canUseAutomaticColumns: Bool

        public init(priceLevel: Int, canUseAutomaticColumns: Bool) {
            self.priceLevel = priceLevel
            self.canUseAutomaticColumns = canUseAutomaticColumns
        }
    }

    public func containsItem(itemNid: Int) -> Bool {
        prices[itemNid] != nil
    }

    public func getPrice(_ item: ItemRecord, priceLevel: Int) -> Money? {
        prices[item.recNid]?[priceLevel]?.withCurrency(currency)
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

    //MARK routines for testing
    public func setNonAutoColumn(priceLevel: Int) {
        columInfos[priceLevel] = ColumnInfo()
    }

    public func setAutoColumn(priceLevel: Int, minimumCases: Int) {
        columInfos[priceLevel] = ColumnInfo(columnMinimum: minimumCases, isCaseMinimum: true)
    }

    public func setAutoColumn(pricelevel: Int, minimumWeight: Int) {
        columInfos[pricelevel] = ColumnInfo(columnMinimum: minimumWeight, isCaseMinimum: false)
    }

    public func assignTo(_ customer: CustomerRecord, priceLevel: Int, canUseAutomaticColumns: Bool) {
        customers[customer.recNid] = PriceSheetRecord.Level(priceLevel: priceLevel, canUseAutomaticColumns: canUseAutomaticColumns)
    }

    public func unassignFrom(_ customer: CustomerRecord) {
        customers.removeValue(forKey: customer.recNid)
    }

    public func assignTo(_ warehouse: WarehouseRecord, priceLevel: Int, canUseAutomaticColumns: Bool) {
        warehouses[warehouse.recNid] = PriceSheetRecord.Level(priceLevel: priceLevel, canUseAutomaticColumns: canUseAutomaticColumns)
    }

    public func unassignFrom(_ warehouse: WarehouseRecord) {
        warehouses.removeValue(forKey: warehouse.recNid)
    }

    /// Set the price of an item in a price column. Note that the price sheet has an assigned currency, so this takes the price without the currency
    public func setPrice(_ item: ItemRecord, priceLevel: Int, price: MoneyWithoutCurrency) {
        let itemNid = item.recNid

        if prices[itemNid] == nil {
            prices[itemNid] = [:]
        }
        prices[itemNid]![priceLevel] = price
    }
}
