public final class ServiceZoneRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var serviceTechEmpNid: Int?
    public var temporaryServiceTechEmpNid: Int?

    public init() {}
}
