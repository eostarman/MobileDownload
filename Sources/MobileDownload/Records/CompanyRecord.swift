import MoneyAndExchangeRates

public final class CompanyRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var HasOverrideForAutoApplyLogic: Bool { doNotAutoIncludeCreditsInDeliverStop || doNotAutoIncludePastDueARInDeliverStop || autoIncludeCreditsMaxAmount != nil }

    public var jpg: String = ""
    public var pcx_or_grf: String = ""

    public var invoiceHeader: String?

    public var hhInvoiceFormatOverride: Int = 0
    public var groupScansheetsByPackage: Bool = false
    public var dexCommID: String = ""

    public var receivablesGroup: Int = 0

    public var distributorDUNSNumber: String = ""

    public var doNotAutoIncludePastDueARInDeliverStop: Bool = false
    public var doNotAutoIncludeCreditsInDeliverStop: Bool = false
    public var autoIncludeCreditsMaxAmount: MoneyWithoutCurrency?

    public var accountingCurrencyNid: Int?

    public init() {}
}
