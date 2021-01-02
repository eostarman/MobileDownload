public final class ItemWriteoffRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var isReturnReasonFlag: Bool = false
    public var isDeliveryAdjustmentReasonFlag: Bool = false
    public var basePricesAndPromosOnQtyOrdered: Bool = false
    public var dateCodeEntryRequired: Bool = false
    public var notForUseOnMobileDevices: Bool = false
    public var useDeliveryDayPriceForReturns: Bool = false
    public var autoPutaway: eAutoPutaway = .Default
    public var returnedProductIsNonSellable: Bool = false
    public var isValidForInMarket: Bool = false
    public var doNotUseForAlcoholStates: String = ""

    public init() {}
}

extension ItemWriteoffRecord {
    public enum eAutoPutaway: Int, Codable {
        case Default = 0
        case CloseToCode = 1
        case Breakage = 2
        case Dunnage = 3
        case Empties = 4
    }
}
