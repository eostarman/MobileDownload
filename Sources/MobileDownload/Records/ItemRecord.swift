import Foundation
import MoneyAndExchangeRates

public final class ItemRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var packageNid: Int?
    public var brandNid: Int?
    public var categoryNid: Int?
    public var taxClassNid: Int?
    public var packName: String = ""
    public var defaultPrice: MoneyWithoutCurrency?
    public var deposit: MoneyWithoutCurrency?
    public var itemWeight: Double = 0
    public var outOfStockDate: Date?

    public var canBuy: Bool = false
    public var canIssue: Bool = false
    public var canSell: Bool = false
    public var isPart: Bool = false
    public var isBillingCode: Bool = false
    public var canOverrideRecName: Bool = false
    public var isSerialized: Bool = false
    public var depositIsSupplierOriginated: Bool = false
    public var isAlcohol: Bool = false
    public var isEmpty: Bool = false
    public var isKeg: Bool = false
    public var isCase: Bool = false
    public var sellOnlyViaAllocations: Bool = false
    public var iDOR: Bool = false
    public var dateCodeTrackingRequired: Bool = false
    public var dateCodeIsSellByDate: Bool = false
    public var isTapHandle: Bool = false
    public var canSample: Bool = false
    public var isPOS: Bool = false
    public var requiresPOSNote: Bool = false
    public var trackPOS: Bool = false
    public var isDunnage: Bool = false
    public var enableStoreLevelDatecodeRecording: Bool = false
    public var isWine: Bool = false
    public var isRedBull: Bool = false
    public var isRawGoods: Bool = false
    public var billingCodeAllowsPriceChanges: Bool = false
    public var billingCodeIsForCredit: Bool = false
    public var billingCodeIsForCharge: Bool = false
    public var billingCodeIsWhilePreselling: Bool = false
    public var billingCodeIsWhileDelivering: Bool = false
    public var inventoryPOS: Bool = false
    public var isGas: Bool = false
    public var ignoresBrandFamilyCanBuyRestriction: Bool = false
    public var isCraftBeer: Bool = false
    public var isLiquor: Bool = false
    public var activeFlag: Bool = false
    public var billingCodeIsForCustomerWeb: Bool = false

    public var altPackNids: [Int] = []
    public var altPackFamilyNid: Int = 0

    public var altPackSequence: Int = 0

    public var altPackCasecount: Int = 0
    public var altPackIsFractionOfPrimaryPack: Bool = false

    public var priceBasisNid: Int?
    public var weightOrMeasure: Double = 0

    public var warehouseLevel: Int = 0
    public var qtyBought_NotReceived: Int = 0

    public var truckLevel: Int = 0

    public var loadedCost: MoneyWithoutCurrency?

    public var defaultPriceEffectiveDate: Date?
    public var defaultPrice2EffectiveDate: Date?
    public var defaultPricePrior: MoneyWithoutCurrency?
    public var defaultPrice2: MoneyWithoutCurrency?

    public var gallonsPerCase: Double = 0

    public var onHand: Int = 0
    public var committed: Int = 0

    public var productClassNid: Int?
    public var retailUPC: String = ""

    public var defaultReturnReasonNid: Int?

    public var itemDeliverySequence: Int = 0

    public var supplierDeposit: MoneyWithoutCurrency?

    public var stockLocation: String = ""
    public var backStockLocation: String = ""

    public var itemPickSeq: Int = 0
    public var nbrPrimaryPacks: Double = 0

    public var packsPerCase: Int = 0

    public var fullDescription: String = ""

    public var crvContainerTypeNid: Int?
    public var unitsPerPack: Int = 0
    public var wineAppellationNid: Int?
    public var wineCharacterNid: Int?
    public var wineClassificationNid: Int?
    public var wineColorNid: Int?
    public var countryNid: Int?
    public var wineRegionNid: Int?
    public var wineTypeNid: Int?
    public var wineVarietalNid: Int?

    public var wineScore1: String = ""
    public var wineScore2: String = ""
    public var wineVintage: String = ""

    public var primarySupNid: Int?

    public var dexPackType: eDEXPackName = .NONE
    public var caseUPC: String = ""

    public var containerNid: Int?
    public var companyNid: Int?
    public var cokePackSize: String = ""
    public var cokeSalesUnit: String = ""

    public var closeDateLevel: Int = 0
    public var dateCodeLabelFormat: eDateCodeLabelFormat = .None

    public var casesPerLayer: Int = 0

    public var casesPerLayerEntries: [CasesPerLayer]?

    public var litersPerCase: Double = 0

    public var addedTime: Date?

    public var length: Double = 0
    public var width: Double = 0
    public var height: Double = 0

    public var shelfPrice: MoneyWithoutCurrency?

    public init() {}
}

extension ItemRecord {
    /// Decode the download "blob" of entries - "2,7;10,10" means if palletSizeNid==2, then qtyPerLayer=7; if palletSizeNid==10 then qtyPerLayer = 10
    public static func getCasesPerLayerEntries(blob: String) -> [CasesPerLayer]? {
        if blob.isEmpty {
            return nil
        }

        var entries: [CasesPerLayer] = []
        for entry in blob.components(separatedBy: ";") {
            let pair = entry.components(separatedBy: ",")
            if pair.count == 2, let palletSizeNid = Int(pair[0]), palletSizeNid > 0, let casesPerLayer = Int(pair[1]) {
                entries.append(CasesPerLayer(palletSizeNid: palletSizeNid, casesPerLayer: casesPerLayer))
            }
        }

        if entries.isEmpty {
            return nil
        }

        return entries
    }

    public struct CasesPerLayer: Codable {
        public let palletSizeNid: Int
        public let casesPerLayer: Int
    }

    public enum eSellCategory {
        case IsBillingCode
        case IsNonAlcoholic
        case IsBeer
        case IsWine
        case IsEmpty
        case IsDunnage
        case IsPart
        case IsPOS
        case IsRawGoods
        case IsTapHandle
        case IsGas
        case IsCraftBeer
        case IsLiquor
    }

    public enum eDEXPackName: Int, Codable {
        case NONE //  0,
        case CA //  1,
        case CT //  2,
        case EA //  3,
        case DZ //  4,
        case GA //  5,
        case KE //  6,
        case KG //  7,
        case LB //  8,
        case PK //  9,
        case PL //  10,
        case TK //  11,
        case UN // 12,
        case BX //  13
    }

    public func getSellCategory() -> eSellCategory {
        if isDunnage { return eSellCategory.IsDunnage }
        if isEmpty { return eSellCategory.IsEmpty }
        if isPart { return eSellCategory.IsPart }
        if isPOS { return eSellCategory.IsPOS }
        if isRawGoods { return eSellCategory.IsRawGoods }
        if isTapHandle { return eSellCategory.IsTapHandle }
        if isBillingCode { return eSellCategory.IsBillingCode }
        if !isAlcohol { return eSellCategory.IsNonAlcoholic }
        if isWine { return eSellCategory.IsWine }
        if isGas { return eSellCategory.IsGas }
        if isCraftBeer { return eSellCategory.IsCraftBeer }
        if isLiquor { return eSellCategory.IsLiquor }
        return eSellCategory.IsBeer // mpr: a bit of a hack - we don't really have an IsBeer flag
    }

    // public var _barcodes: [String]

    public func isBeerOrCraftBeer() -> Bool { getSellCategory() == eSellCategory.IsBeer || getSellCategory() == eSellCategory.IsCraftBeer }
    public func isPrimaryPack() -> Bool { altPackFamilyNid == recNid }
    public func isAltPack() -> Bool { altPackFamilyNid != recNid }
}
