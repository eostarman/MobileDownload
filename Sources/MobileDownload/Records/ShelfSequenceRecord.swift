/// Used for LegacyOrderEntry in eoTouch
public final class ShelfSequenceRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var numberOfAltPacks: Int = 0
    public var altPackFamilyNidsBlob: String = ""

    public init() {}
}
