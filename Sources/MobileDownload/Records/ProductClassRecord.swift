public final class ProductClassRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var isAlcohol: Bool = false // get this (to retain webservice compatibility with old versions) but it's not correct and shouldn't be used
    public var isActive: Bool = false
    public var HasStrictSalesEnforcement: Bool = false

    public init() {}
}
