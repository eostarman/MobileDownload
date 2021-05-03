//
//  RetailerInfo.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 9/18/20.
//

import Foundation


/// Information about the retailer (customer) regarding the locations (back-stock or consumer facing) at the retailer (and lists used during order entry for on-premise accounts mainly)
public class RetailerInfo : Codable, CopyViaJSON {

    public var cusNid: Int = 0

    public var retailLocations: [RetailerList] = []
    public var backstockLocations: [RetailerList] = []
    public var productLists: [RetailerList] = []
    public var itemNotes: [RetailerList.ItemNote] = [] // small numeric notes indicating things to the preseller (like "code 99 means do not order")

    public init() { }

    public var hasRetailOrBackstockLocation: Bool {
        allRetailAndBackstockLocations.count > 0
    }

    public var allRetailAndBackstockLocations: [RetailerList] {
        retailLocations + backstockLocations
    }

    lazy var byID: [Int: RetailerList] = Dictionary(uniqueKeysWithValues: allRetailAndBackstockLocations.map { ($0.id, $0) })

    public subscript(retailerListID: Int) -> RetailerList {
        byID[retailerListID] ?? RetailerList()
    }

    public func retailLocations(for itemNid: Int) -> [RetailerList] {
        retailLocations.filter { $0.containsItem(itemNid: itemNid) }
    }

    public var allLocationsAndLists: [RetailerList] {
        retailLocations + backstockLocations + productLists
    }
}

public class RetailerList: Identifiable, Codable {
    public var id: Int { retailerListTypeNid }

    public var cusNid: Int = 0 // primary key is cusNid, retailerListTypeNid
    public var retailerListTypeNid: Int = 0
    public var retailerListCategory: eRetailerListCategory = .IsGenericLocation

    public var retailerListTypeRecName: String = ""

    public var isProductList: Bool { retailerListCategory == .IsList }
    public var isBackstock: Bool { retailerListCategory == .IsBackstock }
    public var isRetailLocation: Bool { !isProductList && !isBackstock }

    public var eraseWhenPostingToSQL: Bool = false // set in MobileUpload when the user wants to erase an existing list type from a customer

    public var displaySequence: Int = 0

    /// If true, the sequence of list items is automatically maintained. If false, the sequence is managed by the user.  See also: IsCountableOfficeList
    public var isAlphabetical: Bool = false

    /// If true, the contents of the list are automatically maintained.  If false, the contents are managed by the user.  See also: IsCountableOfficeList
    public var isAutomatic: Bool = false

    public var usesRetailerPacks: Bool = false

    public var description: String = ""

    public var sectionBy: eRetailerListSectionBy = .NoSections
    public var itemSelection: eRetailerListItemSelection = .AllItems

    public var placementType: eRetailPlacementType = .NoPlacementInfo
    public var aisleOrRegisterNumber: Int?

    public var sections: [Section] = []

    lazy var byID: [Int: Item] = Dictionary(uniqueKeysWithValues: getAllItems().map { ($0.id, $0) })

    public init() { }
    
    public subscript(retailerListID: Int) -> Item {
        byID[retailerListID] ?? Item()
    }

    public func containsItem(itemNid: Int) -> Bool {
        for section in sections {
            if section.containsItem(itemNid: itemNid) {
                return true
            }
        }
        return false
    }

    public func getAllItems(searchText: String) -> [Item] {
        var filteredItems = [Item]()

        for section in sections {
            filteredItems.append(contentsOf: section.getItems(searchText: searchText))
        }

        return filteredItems
    }

    public func getAllItems() -> [Item] {
        var allItems = [Item]()

        for section in sections {
            allItems.append(contentsOf: section.items)
        }

        return allItems
    }

    public func getSections(searchText: String) -> [Section] {
        if searchText.isEmpty {
            return sections
        }
        var filteredSections = [Section]()

        for section in sections {
            if !section.getItems(searchText: searchText).isEmpty {
                filteredSections.append(section)
            }
        }
        return filteredSections
    }

    public class Section: Identifiable, Codable {
        public var id: Int { sectionNumber }

        public var cusNid: Int = 0
        public var retailerListTypeNid: Int = 0

        public var sectionNumber: Int = 0
        public var sectionBy: eRetailerListSectionBy = .NoSections

        public var sectionRecNid: Int? // BrandNid, CountryNid, PackageNid or CategoryNid
        public var manualSectionName: String? // if the location is sectioned by 'Manual' or 'AllItems' (rather than BrandNid, CountryNid, PackageNid or CategoryNid

        public var items: [Item] = []

        public init() { }

        public func containsItem(itemNid: Int) -> Bool {
            for item in items {
                if item.itemNid == itemNid {
                    return true
                }
            }
            return false
        }

        public func getItems(searchText: String) -> [Item] {
            if searchText.isEmpty {
                return items
            }
            return items.filter { mobileDownload.items.getRecName($0.itemNid).localizedCaseInsensitiveContains(searchText) }
        }

        public func getName() -> String {
            if let manualSectionName = manualSectionName {
                return manualSectionName
            }

            if let sectionRecNid = sectionRecNid {
                switch sectionBy {
                case .Brand:
                    return mobileDownload.brands.getRecName(sectionRecNid)
                case .Category:
                    return mobileDownload.categories.getRecName(sectionRecNid)
                case .Country:
                    return mobileDownload.countries.getRecName(sectionRecNid)
                case .Package:
                    return mobileDownload.packages.getRecName(sectionRecNid)
                default:
                    return ""
                }
            }
            return ""
        }
    }

    public class Item: Identifiable, ObservableObject, Codable {
        public var id: Int { itemNid }

        public init() { }

        public var cusNid: Int = 0
        public var retailerListTypeNid: Int = 0
        public var itemNid: Int = 0

        public var sectionNumber = 0
        public var displaySequence: Int = 0

        public var locationPar: Double? { // 999v99
            willSet {
                objectWillChange.send()
            }
        }
    }

    public class ItemNote : Codable {
        public var cusNid: Int = 0 // primary key: (cusNid, itemNid)
        public var itemNid: Int = 0
        public var eraseWhenPostingToSQL: Bool = false // This is set in MobileUpload when the user wants to erase public an existing list type from a customer
        public var numericNote: Int = 0
        public var empNid: Int = 0
        public var noteEntryDate = Date()

        public init() { }
    }

    /// This is the office list treated like a retail location
    public var IsCountableOfficeList: Bool {
        if !isAlphabetical || !isAutomatic || sectionBy != eRetailerListSectionBy.NoSections || itemSelection != eRetailerListItemSelection.AllItems {
            return false
        }

        switch retailerListCategory {
        case .IsBackstock:
            return false
        case .IsList:
            return false
        default:
            return true
        }
    }

    public var itemSelectionDescription: String? {
        switch itemSelection {
        case eRetailerListItemSelection.Beer:
            return "beer"
        case eRetailerListItemSelection.NonAlcoholic:
            return "non-alcoholic items"
        case eRetailerListItemSelection.Wine:
            return "wine"
        case eRetailerListItemSelection.AllItems:
            return nil
        }
    }

    public var locationDescription: String {
        let description: String

        if let itemSelectionDescription = itemSelectionDescription {
            if retailerListTypeRecName.contains(itemSelectionDescription) {
                description = retailerListTypeRecName
            } else {
                description = "\(itemSelectionDescription) \(retailerListTypeRecName)"
            }
        } else {
            if let aisleOrRegisterNumber = aisleOrRegisterNumber {
                switch placementType {
                case eRetailPlacementType.IsAisle:
                    description = "\(retailerListTypeRecName) on aisle \(aisleOrRegisterNumber)"
                case eRetailPlacementType.IsRegister:
                    description = "\(retailerListTypeRecName) at register \(aisleOrRegisterNumber)"
                default:
                    description = retailerListTypeRecName
                }
            } else {
                description = retailerListTypeRecName
            }
        }

        return description.lowercased()
    }
}

public enum eRetailerListCategory: Int, Codable {
    case IsList = 0 // Menu, ordering list
    case IsGenericLocation = 1 // Warm or Cold Shelf, Cooler, ...
    case IsBackstock = 2 // Backstock location
    case IsDisplay = 3 // display (usually ad-related) that gets built for a short time-period then torn-down,
    case IsWarmShelf = 4
    case IsColdShelf = 5
    case IsCooler = 6 // at the back of a c-store (glass front)
    case IsWalkinCooler = 7 // beer cave
    case IsSmallCooler = 8 // what you'd see at the cash-register
    case IsEndCap = 9
}

// do not change the numeric assignments (I use these to serialize in MobileDatabase and SQL)
public enum eRetailerListAutomationLevel: Int, Codable {
    case Manual = 0 // Both contents and sequence are managed by the user.
    case Alphabetical = 1 // Contents are managed by the user; sequence is automatic.
    case Automatic = 2 // Both contents and sequence are automatic.
}

public enum eRetailerListSectionBy: Int, Codable {
    case Manual = 0 // manual MUST be (0) due to a check-constaint in dbo.RetailerListSections (only manual sections can have a manually-entered name)
    case NoSections = 1 // this is actually a single 'AllItems' section
    case Brand = 2
    case Country = 3
    case Package = 4
    case Category = 5
}

public enum eRetailerListItemSelection: Int, Codable {
    case AllItems = 0
    case NonAlcoholic = 1
    case Beer = 2
    case Wine = 3
}

public enum eRetailPlacementType: Int, Codable {
    case NoPlacementInfo = 0 // must be (0) due to a check-constraint in dbo.RetailerLists (only Locations have plaements, not lists like menus)
    case IsAisle = 1
    case IsRegister = 2
}

public struct RetailPackage {
    public let pkgNid: Int
    public let primaryPackSingular: String
    public let primaryPackPlural: String
    public let retailPack1Singular: String
    public let retailPack1Plural: String
    public let retailPack1UnitsPerCase: Int
    public let retailPack2Singular: String
    public let retailPack2Plural: String
    public let retailPack2UnitsPerCase: Int
}
