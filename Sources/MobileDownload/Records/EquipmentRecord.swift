import Foundation
import MoneyAndExchangeRates

public final class EquipmentRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var manfNid: Int?
    public var equipModelNid: Int?
    public var equipTypeNid: Int?
    public var miscInfo: String = ""
    public var vendInventoryBlob: String = ""
    public var equipmentTransferHistoryBlob: String = ""
    public var vendPlanogramNid: Int?
    public var vendPlanogramFromDate: Date?
    public var vendPlanogramThruDateAsInt: Date?
    public var isVendingMachine: Bool = false
    public var changeFund: MoneyWithoutCurrency?
    public var lockKeyNumber: String = ""
    public var vendSetupString: String = ""
    public var vendServiceSkipDates: String = ""
    public var lastFillDateAsString: String = ""
    public var fillFrequence: String = ""
    public var dexData: String = ""
    public var isUnderReview: Bool = false
    public var brandNid: Int?

    public init() {}
}
