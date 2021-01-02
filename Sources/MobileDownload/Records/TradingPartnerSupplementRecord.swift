public final class TradingPartnerSupplementRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var isDEX4010: Bool = false
    public var sendTotalsInFinalDEXAck: Bool = false
    public var neverDEXSwapOrders: Bool = false
    public var packSizeOverridesBlob: String = ""
    public var vendorIDAndDEXLocationOverridesBlob: String = ""
    public var neverDEXCreditInvoices: Bool = false
    public var convertCasesToPacksForEADex: Bool = false
    public var customerSpecificVendorIDOverridesBlob: String = ""
    public var vendorID: String = ""

    public init() {}
}
