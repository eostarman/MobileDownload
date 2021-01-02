public final class CountyRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var BlacklistLikeCountyNid: Int?
    public var blacklistedBrands: Set<Int> = []

    public init() {}
}
