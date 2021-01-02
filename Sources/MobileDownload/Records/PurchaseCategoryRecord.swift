public final class PurchaseCategoryRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var DisplaySequence: Int = 0
    public var RetailerListCategory: eRetailerListCategory = .IsGenericLocation

    public init() {}
}

extension PurchaseCategoryRecord {
    public enum eRetailerListCategory: Int, Codable {
        case IsList = 0 // Menu, ordering list
        case IsGenericLocation = 1 // Warm or Cold Shelf, Cooler, ...
        case IsBackstock = 2 // Backstock location
        case IsDisplay = 3 // display (usually ad-related) that gets built for a short time-period then torn-down,
        case IsWarmShelf = 4
        case IsColdShelf = 5
        case IsCooler = 6 // at the back of a c-store (glass front)
        case IsWalkinCooler = 7 // beer cave
        case IsSmallCooler = 8 // what you'd see at the cash-register
        case IsEndCap = 9
    }
}
