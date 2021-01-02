public final class OrderTypeRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var isForSamples: Bool = false
    public var isForPOS: Bool = false
    public var isHotshotFlag: Bool = false
    public var isForCumulativePromotions: Bool = false
    public var isBillAndHold: Bool = false
    public var ignoreOrderReturnPartitionRules: Bool = false
    public var isSwap: Bool = false
    public var doNotDEX: Bool = false
    public var isBillAndHoldDeliver: Bool = false
    public var excludeFromUseOnMobileDevices: Bool = false
    public var doNotChargeCrv: Bool = false
    public var excludeFromOneStopDiscounting: Bool = false

    public init() {}
}
