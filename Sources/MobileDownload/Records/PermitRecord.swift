public final class PermitRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    // KJQ 7/30/08 ... it is possible to have a permit with NO items associated ...
    // such a permit covers ALL items (see associated fix in CustomerPrices.cs where we check to see
    // if a permit covers a given item)

    public var altPackFamilyNids: Set<Int>?

    public init() {}
}
