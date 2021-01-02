import Foundation

public final class VendPlanogramRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var planogramFromDate: Date?
    public var planogramThruDate: Date?
    public var vendInventoryBlob: String = ""

    public init() {}
}
