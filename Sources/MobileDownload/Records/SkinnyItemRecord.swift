import Foundation

/// Used for the Brand Manager mobile app prototype
public final class SkinnyItemRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var activeFlag: Bool = false

    public var monthlySalesBlob: String = ""
    public var encodedAltPackString: String = ""
    public var brandNid: Int?
    public var gallonsPerCase: Decimal?
    public var SupNid: Int?
    public var caseUPC: String = ""
    public var retailUPC: String = ""

    public init() {}
}
