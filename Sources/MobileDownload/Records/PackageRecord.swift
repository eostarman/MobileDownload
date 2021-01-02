import MoneyAndExchangeRates

public final class PackageRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var unitDeliveryCharge: MoneyWithoutCurrency?
    public var unitFreight: MoneyWithoutCurrency?
    public var primaryPackSingular: String = ""
    public var primaryPackPlural: String = ""
    public var retailPack1Singular: String = ""
    public var retailPack1Plural: String = ""
    public var retailPack1UnitsPerCase: Int = 0
    public var retailPack2Singular: String = ""
    public var retailPack2Plural: String = ""
    public var retailPack2UnitsPerCase: Int = 0
    public var returnedEmptyItemNidOrZero: String = ""
    public var casesPerLayerByPalletSizeNidBlob: String = ""
    public var prefersKegDeliveryRoute: Bool = false
    public var packageTypeNid: Int?

    public init() {}
}
