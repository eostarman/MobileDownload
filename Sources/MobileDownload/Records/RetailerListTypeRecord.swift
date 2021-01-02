public final class RetailerListTypeRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var displaySequence: Int = 0
    public var retailerListCategory: eRetailerListCategory = .IsGenericLocation

    // public var isProductList: Bool { retailerListCategory == .IsList }
    // public var isLocation: Bool { !isList }
    // public var isBackstock: Bool { retailerListCategory == .IsBackstock }

    public init() {}
}
