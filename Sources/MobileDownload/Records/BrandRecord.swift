public final class BrandRecord: Record, Codable {
    public var id: Int { recNid }
    public var recNid: Int = 0
    public var recKey: String = ""
    public var recName: String = ""

    public var privateLabelChainNid: Int?
    public var brandFamilyNid: Int?

    public var isStrongBeer: Bool = false
    public var isCompetitor: Bool = false
    public var isWine: Bool = false

    public var dateCodeLabelFormat: eDateCodeLabelFormat = .None

    public var beerAvailabilityNid: Int?
    public var beerBreweryNid: Int?
    public var continentNid: Int?
    public var countryNid: Int?
    public var beerCraftCategoryNid: Int?
    public var beerGlasswareNid: Int?
    public var beerRegionCategoryNid: Int?
    public var beerStyleNid: Int?
    public var beerTypeNid: Int?

    public var brandBeverageType: eBrandBeverageType = .Beer

    public var isActive: Bool = false

    public init() {}
}

extension BrandRecord {
    public enum eBrandBeverageType: Int, Codable {
        case NotAssigned = 0
        case Beer = 1
        case Wine = 2
        case Liquor = 3
        case MaltBeverage = 4
        case Water = 5
        case Juice = 6
        case MilkProduct = 7
        case EnergyDrink = 8
        case NonAlcohol_Soda = 9
        case NonBeverage = 10
        case NA_Beer = 11
        case Cider = 12
        case Hard_Seltzer = 13
        case Hard_Kombucha = 14
        case NA_Kombucha = 15
    }
}
