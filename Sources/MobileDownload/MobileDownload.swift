import Foundation

/// The singleton referencing the current mobileDownload
public var mobileDownload = MobileDownload()

public final class MobileDownload {
    public var instanceNumber: Int // handy for debugging memory leaks

    public enum DatabaseSource {
        case none
        case demo
        case live
    }

    public var promoSectionDecoder: ((String, Int) -> PromoSectionRecord.ItemsAndNote)?
    public var salesHistoryDecoder: ((Int, String) -> [CusItemSale])? // mobileDownload.salesHistoryDecoder = CustomerSalesDecoder.decodeSalesHistory

    public var databaseSource: DatabaseSource = .none

    public var databaseName: String?
    public var isValid: Bool {
        databaseName != nil
    }

    public var header = Header()
    public var handheld = HandheldRecord()

    public var palletLines: [PalletLine] = []
    public var customerNotes: [CustomerNote] = []
    public var callSequences: [CallSequence] = []
    public var cusAllocations: [ItemAllocation] = []
    public var taxRates: [TaxRateRecord] = []
    public var arInfoRecords: [Int: [ArInfoRecord]] = [:]
    public var tapHandles = TapHandles()
    public var lastTruckInspection: LastTruckInspection?

    public var actionItemTypes: Records<ActionItemTypeRecord> = .init()
    public var actionItems: Records<ActionItemRecord> = .init()
    public var adAlerts: Records<AdAlertRecord> = .init()
    public var authorizedItemLists: Records<AuthorizedItemListRecord> = .init()
    public var backorderRequests: Records<BackorderRequestRecord> = .init()
    public var barCodes: Records<BarCodeRecord> = .init()
    public var beerAvailabilities: Records<BeerAvailabilityRecord> = .init()
    public var beerBreweries: Records<BeerBreweryRecord> = .init()
    public var beerCraftCategories: Records<BeerCraftCategoryRecord> = .init()
    public var beerGlasswares: Records<BeerGlasswareRecord> = .init()
    public var beerRegionCategories: Records<BeerRegionCategoryRecord> = .init()
    public var beerStyles: Records<BeerStyleRecord> = .init()
    public var beerTypes: Records<BeerTypeRecord> = .init()
    public var brandFamilies: Records<BrandFamilyRecord> = .init()
    public var brands: Records<BrandRecord> = .init()
    public var categories: Records<CategoryRecord> = .init()
    public var chains: Records<ChainRecord> = .init()
    public var companies: Records<CompanyRecord> = .init()
    public var companyGroups: Records<CompanyGroupRecord> = .init()
    public var complaintCodes: Records<ComplaintCodeRecord> = .init()
    public var contacts: Records<ContactRecord> = .init()
    public var containers: Records<ContainerRecord> = .init()
    public var continents: Records<ContinentRecord> = .init()
    public var coops: Records<CoopRecord> = .init()
    public var counties: Records<CountyRecord> = .init()
    public var countries: Records<CountryRecord> = .init()
    public var creditCalendars: Records<CreditCalendarRecord> = .init()
    public var crvContainerTypes: Records<CrvContainerTypeRecord> = .init()
    public var currencies: Records<CurrencyRecord> = .init()
    public var cusLostReasons: Records<CusLostReasonRecord> = .init()
    public var customerProductTargetingRules: Records<CustomerProductTargetingRuleRecord> = .init()
    public var customerSets: Records<CustomerSetRecord> = .init()
    public var customers: Records<CustomerRecord> = .init()
    public var deliveries: Records<DeliveryRecord> = .init()
    public var deliveryCharges: Records<DeliveryChargeRecord> = .init()
    public var displayLocationTypes: Records<DisplayLocationTypeRecord> = .init()
    public var dropPoints: Records<DropPointRecord> = .init()
    public var ediPartners: Records<TradingPartnerRecord> = .init()
    public var employees: Records<EmployeeRecord> = .init()
    public var equipment: Records<EquipmentRecord> = .init()
    public var equipmentModels: Records<EquipmentModelRecord> = .init()
    public var equipmentTypes: Records<EquipmentTypeRecord> = .init()
    public var geographicAreas: Records<GeographicAreaRecord> = .init()
    public var holdCodes: Records<HoldCodeRecord> = .init()
    public var invoiceLogos: Records<InvoiceLogoRecord> = .init()
    public var itemWriteoffs: Records<ItemWriteoffRecord> = .init()
    public var items: Records<ItemRecord> = .init()
    public var manufacturers: Records<ManufacturerRecord> = .init()
    public var mboGoals: Records<MboGoalRecord> = .init()
    public var mboIncentivePrograms: Records<MboIncentiveProgramRecord> = .init()
    public var messages: Records<MessageRecord> = .init()
    public var minimumOrderQtys: Records<MinimumOrderQtyRecord> = .init()
    public var nonServiceReasons: Records<NonServiceReasonRecord> = .init()
    public var objectiveTypes: Records<ObjectiveTypeRecord> = .init()
    public var objectives: Records<ObjectiveRecord> = .init()
    public var orderTypes: Records<OrderTypeRecord> = .init()
    public var ordersToPick: Records<OrderToPickRecord> = .init()
    public var packageTypes: Records<PackageTypeRecord> = .init()
    public var packages: Records<PackageRecord> = .init()
    public var paymentTerms: Records<PaymentTermRecord> = .init()
    public var permits: Records<PermitRecord> = .init()
    public var plants: Records<PlantRecord> = .init()
    public var priceBasis: Records<PriceBasisRecord> = .init()
    public var priceBooks: Records<PriceBookRecord> = .init()
    public var priceRules: Records<PriceRuleRecord> = .init()
    public var priceSheets: Records<PriceSheetRecord> = .init()
    public var productClasses: Records<ProductClassRecord> = .init()
    public var productSets: Records<ProductSetRecord> = .init()
    public var promoCodes: Records<PromoCodeRecord> = .init()
    public var promoSections: Records<PromoSectionRecord> = .init()
    public var purchaseCategories: Records<PurchaseCategoryRecord> = .init()
    public var retailInitiatives: Records<RetailInitiativeRecord> = .init()
    public var retailPlanograms: Records<RetailPlanogramRecord> = .init()
    public var retailPriceLists: Records<RetailPriceListRecord> = .init()
    public var retailerListTypes: Records<RetailerListTypeRecord> = .init()
    public var salesBalancingRules: Records<SalesBalancingRuleRecord> = .init()
    public var salesChannels: Records<SalesChannelRecord> = .init()
    public var serviceZones: Records<ServiceZoneRecord> = .init()
    public var shelfSequences: Records<ShelfSequenceRecord> = .init()
    public var shippers: Records<ShipperRecord> = .init()
    public var skinnyCustomers: Records<SkinnyCustomerRecord> = .init()
    public var skinnyItems: Records<SkinnyItemRecord> = .init()
    public var splitCaseCharges: Records<SplitCaseChargeRecord> = .init()
    public var states: Records<StateRecord> = .init()
    public var suppliers: Records<SupplierRecord> = .init()
    public var surveys: Records<SurveyRecord> = .init()
    public var tapLocations: Records<TapLocationRecord> = .init()
    public var taxAreas: Records<TaxAreaRecord> = .init()
    public var taxClasses: Records<TaxClassRecord> = .init()
    public var tdLinxFoodTypes: Records<TDLinxFoodTypeRecord> = .init()
    public var tdLinxNeighborhoods: Records<TDLinxNeighborhoodRecord> = .init()
    public var tdLinxSubChannels: Records<TDLinxSubChannelRecord> = .init()
    public var tdLinxTradeChannels: Records<TDLinxTradeChannelRecord> = .init()
    public var territories: Records<TerritoryRecord> = .init()
    public var tiCategories: Records<TICategoryRecord> = .init()
    public var tiItems: Records<TIItemRecord> = .init()
    public var tradingPartnerSupplements: Records<TradingPartnerSupplementRecord> = .init()
    public var trucks: Records<TruckRecord> = .init()
    public var uxFields: Records<UxFieldRecord> = .init()
    public var uxSurveyDownloadAnswers: Records<UxSurveyDownloadAnswerRecord> = .init()
    public var uxSurveyLines: Records<UxSurveyLineRecord> = .init()
    public var uxSurveys: Records<UxSurveyRecord> = .init()
    public var vendPlanograms: Records<VendPlanogramRecord> = .init()
    public var voidReasons: Records<VoidReasonRecord> = .init()
    public var wBTGMenus: Records<WBTGMenuRecord> = .init()
    public var warehouses: Records<WarehouseRecord> = .init()
    public var webLinkAudiences: Records<WebLinkAudienceRecord> = .init()
    public var webLinks: Records<WebLinkRecord> = .init()
    public var wineAppellations: Records<WineAppellationRecord> = .init()
    public var wineCharacters: Records<WineCharacterRecord> = .init()
    public var wineClassifications: Records<WineClassificationRecord> = .init()
    public var wineColors: Records<WineColorRecord> = .init()
    public var wineRegions: Records<WineRegionRecord> = .init()
    public var wineTypes: Records<WineTypeRecord> = .init()
    public var wineVarietals: Records<WineVarietalRecord> = .init()

    public init() {
        Self.numberOfInits += 1
        instanceNumber = Self.numberOfInits
    }

    deinit {
        if let databaseName = databaseName {
            NSLog("MobileDownload #\(Self.numberOfInits): deinit() \(databaseName)")
        }
    }

    public class Header: Codable {
        public var startTime: Date = .distantPast
        public var stopTime: Date = .distantPast
        public var serverName: String = ""
        public var databaseName: String = ""
        public var numberOfTables: Int = 0
        public var totalNumberOfRecords: Int = 0
        public var isProductionDatabase: Bool = false

        public init() { }
    }

    public static var numberOfInits: Int = 0
}
