public final class CurrencyRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var currencySymbol: String = ""

    public init() {}
}
