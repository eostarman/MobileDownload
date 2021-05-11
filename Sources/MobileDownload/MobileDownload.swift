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
    
    /// the actual employee (not the "route")
    public var loggedInEmpNid: Int {
        handheld.actualEmpNid
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
    public var customerRetailPlanograms: [CustomerRetailPlanogram] = []

    public var actionItemTypes: Records<ActionItemTypeRecord> = .init(.ActionItemTypes)
    public var actionItems: Records<ActionItemRecord> = .init(.ActionItems)
    public var adAlerts: Records<AdAlertRecord> = .init(.AdAlerts)
    public var authorizedItemLists: Records<AuthorizedItemListRecord> = .init(.AuthorizedItemLists)
    public var backorderRequests: Records<BackorderRequestRecord> = .init(.BackorderRequests)
    public var barCodes: Records<BarCodeRecord> = .init(.BarCodes)
    public var beerAvailabilities: Records<BeerAvailabilityRecord> = .init(.BeerAvailabilities)
    public var beerBreweries: Records<BeerBreweryRecord> = .init(.BeerBreweries)
    public var beerCraftCategories: Records<BeerCraftCategoryRecord> = .init(.BeerCraftCategories)
    public var beerGlasswares: Records<BeerGlasswareRecord> = .init(.BeerGlasswares)
    public var beerRegionCategories: Records<BeerRegionCategoryRecord> = .init(.BeerRegionCategories)
    public var beerStyles: Records<BeerStyleRecord> = .init(.BeerStyles)
    public var beerTypes: Records<BeerTypeRecord> = .init(.BeerTypes)
    public var brandFamilies: Records<BrandFamilyRecord> = .init(.BrandFamilies)
    public var brands: Records<BrandRecord> = .init(.Brands)
    public var categories: Records<CategoryRecord> = .init(.Categories)
    public var chains: Records<ChainRecord> = .init(.Chains)
    public var companies: Records<CompanyRecord> = .init(.Companies)
    public var companyGroups: Records<CompanyGroupRecord> = .init(.CompanyGroups)
    public var complaintCodes: Records<ComplaintCodeRecord> = .init(.ComplaintCodes)
    public var contacts: Records<ContactRecord> = .init(.Contacts)
    public var containers: Records<ContainerRecord> = .init(.Containers)
    public var continents: Records<ContinentRecord> = .init(.Continents)
    public var coops: Records<CoopRecord> = .init(.Coops)
    public var counties: Records<CountyRecord> = .init(.Counties)
    public var countries: Records<CountryRecord> = .init(.Countries)
    public var creditCalendars: Records<CreditCalendarRecord> = .init(.CreditCalendars)
    public var crvContainerTypes: Records<CrvContainerTypeRecord> = .init(.CrvContainerTypes)
    public var currencies: Records<CurrencyRecord> = .init(.Currencies)
    public var cusLostReasons: Records<CusLostReasonRecord> = .init(.CusLostReasons)
    public var customerProductTargetingRules: Records<CustomerProductTargetingRuleRecord> = .init(.CustomerProductTargetingRules)
    public var customerSets: Records<CustomerSetRecord> = .init(.CustomerSets)
    public var customers: Records<CustomerRecord> = .init(.Customers)
    public var deliveries: Records<DeliveryRecord> = .init(.Deliveries)
    public var deliveryCharges: Records<DeliveryChargeRecord> = .init(.DeliveryCharges)
    public var displayLocationTypes: Records<DisplayLocationTypeRecord> = .init(.DisplayLocationTypes)
    public var dropPoints: Records<DropPointRecord> = .init(.DropPoints)
    public var ediPartners: Records<TradingPartnerRecord> = .init(.EdiPartners)
    public var employees: Records<EmployeeRecord> = .init(.Employees)
    public var equipment: Records<EquipmentRecord> = .init(.Equipment)
    public var equipmentModels: Records<EquipmentModelRecord> = .init(.EquipmentModels)
    public var equipmentTypes: Records<EquipmentTypeRecord> = .init(.EquipmentTypes)
    public var geographicAreas: Records<GeographicAreaRecord> = .init(.GeographicAreas)
    public var holdCodes: Records<HoldCodeRecord> = .init(.HoldCodes)
    public var invoiceLogos: Records<InvoiceLogoRecord> = .init(.InvoiceLogos)
    public var itemWriteoffs: Records<ItemWriteoffRecord> = .init(.ItemWriteoffs)
    public var items: Records<ItemRecord> = .init(.Items)
    public var manufacturers: Records<ManufacturerRecord> = .init(.Manufacturers)
    public var mboGoals: Records<MboGoalRecord> = .init(.MboGoals)
    public var mboIncentivePrograms: Records<MboIncentiveProgramRecord> = .init(.MboIncentivePrograms)
    public var messages: Records<MessageRecord> = .init(.Messages)
    public var minimumOrderQtys: Records<MinimumOrderQtyRecord> = .init(.MinimumOrderQtys)
    public var nonServiceReasons: Records<NonServiceReasonRecord> = .init(.NonServiceReasons)
    public var objectiveTypes: Records<ObjectiveTypeRecord> = .init(.ObjectiveTypes)
    public var objectives: Records<ObjectiveRecord> = .init(.Objectives)
    public var orderTypes: Records<OrderTypeRecord> = .init(.OrderTypes)
    public var ordersToPick: Records<OrderToPickRecord> = .init(.OrdersToPick)
    public var packageTypes: Records<PackageTypeRecord> = .init(.PackageTypes)
    public var packages: Records<PackageRecord> = .init(.Packages)
    public var paymentTerms: Records<PaymentTermRecord> = .init(.PaymentTerms)
    public var permits: Records<PermitRecord> = .init(.Permits)
    public var plants: Records<PlantRecord> = .init(.Plants)
    public var priceBasis: Records<PriceBasisRecord> = .init(.PriceBasis)
    public var priceBooks: Records<PriceBookRecord> = .init(.PriceBooks)
    public var priceRules: Records<PriceRuleRecord> = .init(.PriceRules)
    public var priceSheets: Records<PriceSheetRecord> = .init(.PriceSheets)
    public var productClasses: Records<ProductClassRecord> = .init(.ProductClasses)
    public var productSets: Records<ProductSetRecord> = .init(.ProductSets)
    public var promoCodes: Records<PromoCodeRecord> = .init(.PromoCodes)
    public var promoSections: Records<PromoSectionRecord> = .init(.PromoSections)
    public var purchaseCategories: Records<PurchaseCategoryRecord> = .init(.PurchaseCategories)
    public var retailInitiatives: Records<RetailInitiativeRecord> = .init(.RetailInitiatives)
    public var retailPlanograms: Records<RetailPlanogramRecord> = .init(.RetailPlanograms)
    public var retailPriceLists: Records<RetailPriceListRecord> = .init(.RetailPriceLists)
    public var retailerListTypes: Records<RetailerListTypeRecord> = .init(.RetailerListTypes)
    public var salesBalancingRules: Records<SalesBalancingRuleRecord> = .init(.SalesBalancingRules)
    public var salesChannels: Records<SalesChannelRecord> = .init(.SalesChannels)
    public var serviceZones: Records<ServiceZoneRecord> = .init(.ServiceZones)
    public var shelfSequences: Records<ShelfSequenceRecord> = .init(.ShelfSequences)
    public var shippers: Records<ShipperRecord> = .init(.Shippers)
    public var skinnyCustomers: Records<SkinnyCustomerRecord> = .init(.SkinnyCustomers)
    public var skinnyItems: Records<SkinnyItemRecord> = .init(.SkinnyItems)
    public var splitCaseCharges: Records<SplitCaseChargeRecord> = .init(.SplitCaseCharges)
    public var states: Records<StateRecord> = .init(.States)
    public var suppliers: Records<SupplierRecord> = .init(.Suppliers)
    public var surveys: Records<SurveyRecord> = .init(.Surveys)
    public var tapLocations: Records<TapLocationRecord> = .init(.TapLocations)
    public var taxAreas: Records<TaxAreaRecord> = .init(.TaxAreas)
    public var taxClasses: Records<TaxClassRecord> = .init(.TaxClasses)
    public var tdLinxFoodTypes: Records<TDLinxFoodTypeRecord> = .init(.TDLinxFoodTypes)
    public var tdLinxNeighborhoods: Records<TDLinxNeighborhoodRecord> = .init(.TDLinxNeighborhoods)
    public var tdLinxSubChannels: Records<TDLinxSubChannelRecord> = .init(.TDLinxSubChannels)
    public var tdLinxTradeChannels: Records<TDLinxTradeChannelRecord> = .init(.TDLinxTradeChannels)
    public var territories: Records<TerritoryRecord> = .init(.Territories)
    public var tiCategories: Records<TICategoryRecord> = .init(.TICategories)
    public var tiItems: Records<TIItemRecord> = .init(.TIItems)
    public var tradingPartnerSupplements: Records<TradingPartnerSupplementRecord> = .init(.TradingPartnerSupplements)
    public var trucks: Records<TruckRecord> = .init(.Trucks)
    public var uxFields: Records<UxFieldRecord> = .init(.UxFields)
    public var uxSurveyDownloadAnswers: Records<UxSurveyDownloadAnswerRecord> = .init(.UxSurveyDownloadAnswers)
    public var uxSurveyLines: Records<UxSurveyLineRecord> = .init(.UxSurveyLines)
    public var uxSurveys: Records<UxSurveyRecord> = .init(.Surveys)
    public var vendPlanograms: Records<VendPlanogramRecord> = .init(.VendPlanograms)
    public var voidReasons: Records<VoidReasonRecord> = .init(.VoidReasons)
    public var wBTGMenus: Records<WBTGMenuRecord> = .init(.WBTGMenus)
    public var warehouses: Records<WarehouseRecord> = .init(.Warehouses)
    public var webLinkAudiences: Records<WebLinkAudienceRecord> = .init(.WebLinkAudiences)
    public var webLinks: Records<WebLinkRecord> = .init(.WebLinks)
    public var wineAppellations: Records<WineAppellationRecord> = .init(.WineAppellations)
    public var wineCharacters: Records<WineCharacterRecord> = .init(.WineCharacters)
    public var wineClassifications: Records<WineClassificationRecord> = .init(.WineClassifications)
    public var wineColors: Records<WineColorRecord> = .init(.WineColors)
    public var wineRegions: Records<WineRegionRecord> = .init(.WineRegions)
    public var wineTypes: Records<WineTypeRecord> = .init(.WineTypes)
    public var wineVarietals: Records<WineVarietalRecord> = .init(.WineVarietals)

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
