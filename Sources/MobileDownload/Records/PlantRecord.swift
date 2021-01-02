public final class PlantRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var suppliersAssociatedWithPlant: [Int] = []

    public init() {}
}

extension PlantRecord {
    // KJQ 10/8/09 ... added "plants" support to the handheld, so now downloading the Plant records and embedding in each record
    // a blob that indicates what suppliers are associated with a particular plant

    func isSupplierAssociatedWithPlant(supNid: Int) -> Bool {
        suppliersAssociatedWithPlant.contains(supNid)
    }
}
