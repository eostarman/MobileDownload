import Foundation

public final class AdAlertRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var fromDate = Date.distantPast
    public var thruDate = Date.distantPast
    public var promoTypeRecName: String = ""
    public var displayAuthRecName: String = ""
    public var displayLocationRecName: String = ""
    public var promoTypeCode: String = ""
    public var comments: String = ""
    public var promoTypePriority: Int = 0
    public var unitPrice: Int = 0
    public var minCaseRequirement: Int = 0
    public var cusNids: [Int] = []
    public var customerRulesDescription: String = ""
    public var itemNids: [Int] = []
    public var productRulesDescription: String = ""
    public var complianceBytesBlob: String = ""

    public var acknowledgementRequiredAtTimeOfService: Bool = false
    public var logIsPriceCompliant: Bool = false
    public var logIsDisplayCompliant: Bool = false
    public var logIsPOSCompliant: Bool = false
    public var adAlertFirstVisitCompliance: Bool = false
    public var adAlertSecondVisitCompliance: Bool = false
    public var adAlertOnOrBeforeLastVisitCompliance: Bool = false

    public init() {}
}
