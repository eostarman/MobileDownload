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
    public var retailPlanogramVisualURL: String?
    public var readyToDeploy: Bool = false
    
    public var retailPlanogramLocations: [RetailPlanogramLocation] = []

    public init() {}
}

public class RetailPlanogramLocation: Codable, Identifiable {

    public var retailerListTypeNid: Int = 0
    public var locationVisualURL: String?
    public var displaySequence: Int = 0
    public var retailPlanogramItems: [RetailPlanogramItem] = []
    
    public init() {}
}


public class RetailPlanogramItem: Codable, Identifiable {

    public var itemNid: Int = 0
    public var displaySequence: Int = 0
    /// nil == leave the dbo.RetailerListItem.LocationPar alone (keep any existing value)
    /// Zero == reset the dbo.RetailerListItem.LocationPar to nil
    /// Anything else == set the dbo.RetailerListItem.LocationPar to that value
    public var par: Double? // in c# this is Decimal
    
    public init() {}
}
