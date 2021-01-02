import Foundation

public final class RetailPlanogramRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var activeFlag: Bool = false
    public var addedByEmpNid: Int?
    public var addedTime: Date?
    public var description: String = ""
    public var retailPlanogramVisualURL: String = ""
    public var readyToDeploy: Bool = false
    public var retailPlanogramLocations: String = ""

    public init() {}
}
