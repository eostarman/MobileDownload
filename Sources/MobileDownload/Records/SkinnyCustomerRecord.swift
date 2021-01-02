/// Used for the Brand Manager mobile app prototype
public final class SkinnyCustomerRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var shipLatitude: Double?
    public var shipLongitude: Double?
    public var shipCity: String = ""
    public var shipState: String = ""
    public var tdLinxChannel: Int = 0
    public var tdLinxSubChannel: Int = 0
    public var tdLinxFoodType: Int = 0
    public var tdLinxNeighborhood: Int = 0
    public var slsChanNid: Int?
    public var geoAreaNid: Int?
    public var chainNid: Int?
    public var whseNid: Int = 0

    public var activeFlag: Bool = false
    public var isOffPremise: Bool = false
    public var isNonRetail: Bool = false
    public var isDistributor: Bool = false

    public init() {}
}
