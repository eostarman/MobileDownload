import Foundation
import MoneyAndExchangeRates

public final class WarehouseRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var shipAdr1: String = ""
    public var shipAdr2: String = ""
    public var shipCity: String = ""
    public var shipState: String = ""
    public var shipZip: String = ""
    public var shipAdr3: String = ""
    public var whseAreasBlob: String = ""
    public var kegDeposit: MoneyWithoutCurrency?
    public var shipLatitude: Double?
    public var shipLongitude: Double?
    public var defaultOffDayDeliveryDriverNidString: Int = 0
    public var noSellDaysBlob: String = ""
    public var hasKegDeposit: Bool = false
    public var companyNid: Int?
    public var vendProductSetNid: Int?
    public var warehouseInventoryAvailabilityBlob: String = ""
    public var palletOptimizationCoreItemsBlob: String = ""
    public var onOrderBlob: String = ""
    public var palletOptimizationUseLayerPickRounding: Bool = false
    public var palletOptimizationUsePercentCompleteLayerRounding: Bool = false
    public var palletOptimizationUsePackageFillLayerRounding: Bool = false
    public var layerRoundingPercentCompleteMinimum: Decimal?
    public var layerRoundingPackageFillPercentMinimum: Decimal?
    public var percentCompleteItemsBlob: String = ""
    public var palletOptimizationLayerFillerItems: String = ""
    public var nextDayDeliveryCutoffTime: String = ""
    public var nextDayDeliveryCutoffWarningWindowInMinutes: Int = 0
    public var allowMobileHotShotRequests: Bool = false
    public var sellableItemsProductSetNid: Int?
    public var truckReplenSettingsBlob: String = ""
    public var inMarketSameProduct: Bool = false

    public var warehouseSellabilityOverrides: [WarehouseSellabilityOverride] = []

    public init() {}
}
