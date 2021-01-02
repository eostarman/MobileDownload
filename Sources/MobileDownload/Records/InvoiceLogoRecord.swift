public final class InvoiceLogoRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var jpg: String = ""
    public var pcx_or_grf: String = ""

    public init() {}
}
