//
//  RecordSet.Swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/12/20.
//

import Foundation

/// The values MUST match the tableNames in the MobileDownload (with two exceptions for clarity). These are the sets of so-called "plus-options" from eoStar
public enum RecordSet: CaseIterable {
    case Handhelds
    case Deliveries
    case Customers
    case CustomerSets
    case PriceRules
    case Permits
    case AdAlerts
    case RetailPriceLists
    case AuthorizedItemLists
    case ProductSets
    case BarCodes
    case BrandFamilies
    case Brands
    case Categories
    case Contacts
    case CusLostReasons
    case DeliveryCharges
    case OrdersToPick
    case DropPoints
    case Employees
    case Chains
    case GeographicAreas
    case HoldCodes
    case Companies
    case Items
    case ItemWriteoffs
    case NonServiceReasons
    case OrderTypes
    case Packages
    case PaymentTerms
    case CreditCalendars
    case PriceBasis
    case PriceBooks
    case PriceSheets
    case ProductClasses
    case PromoSections
    case PromoCodes
    case SalesChannels
    case ShelfSequences
    case TaxAreas
    case CrvContainerTypes
    case TaxClasses
    case Trucks
    case Warehouses
    case RetailInitiatives
    case Surveys
    case Shippers
    case States
    case Suppliers
    case PurchaseCategories
    case Plants
    case InvoiceLogos
    case MboGoals
    case MboIncentivePrograms
    case TapLocations
    case WBTGMenus
    case Territories
    case Messages
    case TICategories
    case TIItems
    case UxFields
    case UxSurveys
    case UxSurveyLines
    case UxSurveyDownloadAnswers
    case EdiPartners
    case TradingPartnerSupplements
    case Equipment
    case EquipmentTypes
    case EquipmentModels
    case Manufacturers
    case VendPlanograms
    case WineAppellations
    case WineCharacters
    case WineClassifications
    case WineColors
    case Countries
    case Currencies
    case WineRegions
    case WineTypes
    case WineVarietals
    case BeerAvailabilities
    case BeerBreweries
    case Continents
    case BeerCraftCategories
    case BeerGlasswares
    case BeerRegionCategories
    case BeerStyles
    case BeerTypes
    case SplitCaseCharges
    case Containers
    case ObjectiveTypes
    case Objectives
    case VoidReasons
    case RetailerListTypes
    case BackorderRequests
    case CustomerProductTargetingRules
    case Coops
    case ActionItemTypes
    case ActionItems
    case MinimumOrderQtys
    case SkinnyCustomers
    case SkinnyItems
    case TDLinxNeighborhoods
    case TDLinxFoodTypes
    case TDLinxSubChannels
    case TDLinxTradeChannels
    case ServiceZones
    case Counties
    case CompanyGroups
    case SalesBalancingRules
    case ComplaintCodes
    case WebLinks
    case WebLinkAudiences
    case RetailPlanograms
    case DisplayLocationTypes
    case PackageTypes

    public var tableName: String {
        switch self {
        case .Chains: return "FamilyMajorAccounts"
        case .PromoSections: return "Promotions"
        default:
            return String(describing: self)
        }
    }

    public func singularOrPluralCaption(_ numberOfRecords: Int) -> String {
        numberOfRecords == 1 ? singularCaption : pluralCaption
    }

    public func getMessage(verb: String, numberOfRecords: Int) -> String {
        let msg: String
        if numberOfRecords == 1 {
            msg = "\(verb) 1 \(singularCaption)" // "promoting 1 item"
        } else {
            msg = "\(verb) \(numberOfRecords) \(pluralCaption)" // "displaying 5 items"
        }
        return msg
    }

    public var singularCaption: String {
        switch self {
        case .Deliveries: return "Delivery"
        case .Customers: return "Customer"
        case .CustomerSets: return "Customer Set"
        case .PriceRules: return "Price Rule"
        case .Permits: return "Permit"
        case .AdAlerts: return "Ad Alert"
        case .RetailPriceLists: return "Retail Price List"
        case .AuthorizedItemLists: return "Authorized Item List"
        case .ProductSets: return "Product Set"
        case .BarCodes: return "Barcode"
        case .BrandFamilies: return "Brand Family"
        case .Brands: return "Brand"
        case .Categories: return "Category"
        case .Contacts: return "Contact"
        case .CusLostReasons: return "CusLost Reason"
        case .DeliveryCharges: return "Delivery Charge"
        case .OrdersToPick: return "Order To Pick"
        case .DropPoints: return "Drop Point"
        case .Employees: return "Employee"
        case .Chains: return "Chain"
        case .GeographicAreas: return "Geographic Area"
        case .HoldCodes: return "Hold Code"
        case .Companies: return "Company"
        case .Items: return "Item"
        case .ItemWriteoffs: return "Item Writeoff"
        case .NonServiceReasons: return "Non-service Reason"
        case .OrderTypes: return "Order Type"
        case .Packages: return "Package"
        case .PaymentTerms: return "Payment Term"
        case .CreditCalendars: return "Credit Calendar"
        case .PriceBasis: return "Price Basis"
        case .PriceBooks: return "Price Book"
        case .PriceSheets: return "Price Sheet"
        case .ProductClasses: return "Product Class"
        case .PromoSections: return "Promo Section"
        case .PromoCodes: return "Promo Code"
        case .SalesChannels: return "Sales Channel"
        case .ShelfSequences: return "Shelf Sequence"
        case .TaxAreas: return "Tax Area"
        case .CrvContainerTypes: return "CRV Container Type"
        case .TaxClasses: return "Tax Class"
        case .Trucks: return "Truck"
        case .Warehouses: return "Warehouse"
        case .RetailInitiatives: return "Retail Initiative"
        case .Surveys: return "Survey"
        case .Shippers: return "Shipper"
        case .States: return "State"
        case .Suppliers: return "Supplier"
        case .PurchaseCategories: return "Purchase Category"
        case .Plants: return "Plant"
        case .InvoiceLogos: return "Invoice Logo"
        case .MboGoals: return "MBO Goal"
        case .MboIncentivePrograms: return "MBO Incentive Program"
        case .TapLocations: return "Tap Location"
        case .WBTGMenus: return "WBTG Menu"
        case .Territories: return "Territory"
        case .Messages: return "Message"
        case .TICategories: return "Truck Inspection Category"
        case .TIItems: return "Truck Inspection Item"
        case .UxFields: return "UX Field"
        case .UxSurveys: return "UX Survey"
        case .UxSurveyLines: return "UX Survey Line"
        case .UxSurveyDownloadAnswers: return "UX Survey Download Answer"
        case .EdiPartners: return "EDI Partner"
        case .TradingPartnerSupplements: return "Trading Partner Supplement"
        case .Equipment: return "Equipment"
        case .EquipmentTypes: return "Equipment Type"
        case .EquipmentModels: return "Equipment Model"
        case .Manufacturers: return "Manufacturer"
        case .VendPlanograms: return "Vend Planogram"
        case .WineAppellations: return "Wine Appellation"
        case .WineCharacters: return "Wine Character"
        case .WineClassifications: return "Wine Classification"
        case .WineColors: return "Wine Color"
        case .Countries: return "Country"
        case .Currencies: return "Currency"
        case .WineRegions: return "Wine Region"
        case .WineTypes: return "Wine Type"
        case .WineVarietals: return "Wine Varietal"
        case .BeerAvailabilities: return "Beer Availability"
        case .BeerBreweries: return "Beer Brewery"
        case .Continents: return "Continent"
        case .BeerCraftCategories: return "Beer Craft Category"
        case .BeerGlasswares: return "Beer Glassware"
        case .BeerRegionCategories: return "Beer Region Category"
        case .BeerStyles: return "Beer Style"
        case .BeerTypes: return "Beer Type"
        case .SplitCaseCharges: return "Split Case Charge"
        case .Containers: return "Container"
        case .ObjectiveTypes: return "Objective Type"
        case .Objectives: return "Objective"
        case .VoidReasons: return "Void Reason"
        case .RetailerListTypes: return "Retailer List Type"
        case .BackorderRequests: return "Backorder Request"
        case .CustomerProductTargetingRules: return "Customer-Product Targeting Rule"
        case .Coops: return "Coop"
        case .ActionItemTypes: return "Action Item Type"
        case .ActionItems: return "Action Item"
        case .MinimumOrderQtys: return "Minimum Order quantity"
        case .SkinnyCustomers: return "Skinny Customer"
        case .SkinnyItems: return "Skinny Item"
        case .TDLinxNeighborhoods: return "TD Linx Neighborhood"
        case .TDLinxFoodTypes: return "TD Linx Food Type"
        case .TDLinxSubChannels: return "TD Linx Sub Channel"
        case .TDLinxTradeChannels: return "TD Linx Trade Channel"
        case .ServiceZones: return "Service Zone"
        case .Counties: return "County"
        case .CompanyGroups: return "Company Group"
        case .SalesBalancingRules: return "Sales Balancing Rule"
        case .ComplaintCodes: return "Complaint Code"
        case .WebLinks: return "Web Link"
        case .WebLinkAudiences: return "Web Link Audience"
        case .RetailPlanograms: return "Retail Planogram"
        case .DisplayLocationTypes: return "Display Location Type"
        case .PackageTypes: return "Package Type"
        case .Handhelds: return "Handheld"
        }
    }

    var pluralCaption: String {
        switch self {
        case .Deliveries: return "Deliveries"
        case .Customers: return "Customers"
        case .CustomerSets: return "Customer Sets"
        case .PriceRules: return "Price Rules"
        case .Permits: return "Permits"
        case .AdAlerts: return "Ad Alerts"
        case .RetailPriceLists: return "Retail Price Lists"
        case .AuthorizedItemLists: return "Authorized Item Lists"
        case .ProductSets: return "Product Sets"
        case .BarCodes: return "Barcodes"
        case .BrandFamilies: return "Brand Families"
        case .Brands: return "Brands"
        case .Categories: return "Categories"
        case .Contacts: return "Contacts"
        case .CusLostReasons: return "CusLost Reasons"
        case .DeliveryCharges: return "Delivery Charges"
        case .OrdersToPick: return "Orders To Picks"
        case .DropPoints: return "Drop Points"
        case .Employees: return "Employees"
        case .Chains: return "Chains"
        case .GeographicAreas: return "Geographic Areas"
        case .HoldCodes: return "Hold Codes"
        case .Companies: return "Companies"
        case .Items: return "Items"
        case .ItemWriteoffs: return "Item Writeoffs"
        case .NonServiceReasons: return "Non-service Reasons"
        case .OrderTypes: return "Order Types"
        case .Packages: return "Packages"
        case .PaymentTerms: return "Payment Terms"
        case .CreditCalendars: return "Credit Calendars"
        case .PriceBasis: return "Price Basis records"
        case .PriceBooks: return "Price Books"
        case .PriceSheets: return "Price Sheets"
        case .ProductClasses: return "Product Classes"
        case .PromoSections: return "Promo Sections"
        case .PromoCodes: return "Promo Codes"
        case .SalesChannels: return "Sales Channels"
        case .ShelfSequences: return "Shelf Sequences"
        case .TaxAreas: return "Tax Areas"
        case .CrvContainerTypes: return "CRV Container Types"
        case .TaxClasses: return "Tax Classes"
        case .Trucks: return "Trucks"
        case .Warehouses: return "Warehouses"
        case .RetailInitiatives: return "Retail Initiatives"
        case .Surveys: return "Surveys"
        case .Shippers: return "Shippers"
        case .States: return "States"
        case .Suppliers: return "Suppliers"
        case .PurchaseCategories: return "Purchase Categories"
        case .Plants: return "Plants"
        case .InvoiceLogos: return "Invoice Logos"
        case .MboGoals: return "MBO Goals"
        case .MboIncentivePrograms: return "MBO Incentive Programs"
        case .TapLocations: return "Tap Locations"
        case .WBTGMenus: return "WBTG Menus"
        case .Territories: return "Territories"
        case .Messages: return "Messages"
        case .TICategories: return "Truck Inspection Categories"
        case .TIItems: return "Truck Inspection Items"
        case .UxFields: return "UX Fields"
        case .UxSurveys: return "UX Surveys"
        case .UxSurveyLines: return "UX Survey Lines"
        case .UxSurveyDownloadAnswers: return "UX Survey Download Answers"
        case .EdiPartners: return "EDI Partners"
        case .TradingPartnerSupplements: return "Trading Partner Supplements"
        case .Equipment: return "Equipments"
        case .EquipmentTypes: return "Equipment Types"
        case .EquipmentModels: return "Equipment Models"
        case .Manufacturers: return "Manufacturers"
        case .VendPlanograms: return "Vend Planograms"
        case .WineAppellations: return "Wine Appellations"
        case .WineCharacters: return "Wine Characters"
        case .WineClassifications: return "Wine Classifications"
        case .WineColors: return "Wine Colors"
        case .Countries: return "Countries"
        case .Currencies: return "Currencies"
        case .WineRegions: return "Wine Regions"
        case .WineTypes: return "Wine Types"
        case .WineVarietals: return "Wine Varietals"
        case .BeerAvailabilities: return "Beer Availabilities"
        case .BeerBreweries: return "Beer Breweries"
        case .Continents: return "Continents"
        case .BeerCraftCategories: return "Beer Craft Categories"
        case .BeerGlasswares: return "Beer Glasswares"
        case .BeerRegionCategories: return "Beer Region Categories"
        case .BeerStyles: return "Beer Styles"
        case .BeerTypes: return "Beer Types"
        case .SplitCaseCharges: return "Split Case Charges"
        case .Containers: return "Containers"
        case .ObjectiveTypes: return "Objective Types"
        case .Objectives: return "Objectives"
        case .VoidReasons: return "Void Reasons"
        case .RetailerListTypes: return "Retailer List Types"
        case .BackorderRequests: return "Backorder Requests"
        case .CustomerProductTargetingRules: return "Customer-Product Targeting Rules"
        case .Coops: return "Coops"
        case .ActionItemTypes: return "Action Item Types"
        case .ActionItems: return "Action Items"
        case .MinimumOrderQtys: return "Minimum Order quantities"
        case .SkinnyCustomers: return "Skinny Customers"
        case .SkinnyItems: return "Skinny Items"
        case .TDLinxNeighborhoods: return "TD Linx Neighborhoods"
        case .TDLinxFoodTypes: return "TD Linx Food Types"
        case .TDLinxSubChannels: return "TD Linx Sub Channels"
        case .TDLinxTradeChannels: return "TD Linx Trade Channels"
        case .ServiceZones: return "Service Zones"
        case .Counties: return "Counties"
        case .CompanyGroups: return "Company Groups"
        case .SalesBalancingRules: return "Sales Balancing Rules"
        case .ComplaintCodes: return "Complaint Codes"
        case .WebLinks: return "Web Links"
        case .WebLinkAudiences: return "Web Link Audiences"
        case .RetailPlanograms: return "Retail Planograms"
        case .DisplayLocationTypes: return "Display Location Types"
        case .PackageTypes: return "Package Types"
        case .Handhelds: return "Handhelds"
        }
    }
}
