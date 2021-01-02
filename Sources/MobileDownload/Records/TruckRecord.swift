public final class TruckRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var whseNid: Int = 0
    public var returnWhseNid: Int?
    public var stripTruckFlag: Bool = false
    public var defaultTruckStripType: Int = 0
    public var serviceTruckFlag: Bool = false
    public var truckUsesPreorders: Bool = false

    public var productClassBit1: Bool = false
    public var productClassBit2: Bool = false
    public var productClassBit3: Bool = false
    public var productClassBit4: Bool = false
    public var productClassBit5: Bool = false
    public var productClassBit6: Bool = false
    public var productClassBit7: Bool = false
    public var productClassBit8: Bool = false
    public var productClassBit9: Bool = false
    public var productClassBit10: Bool = false

    public init() {}
}
