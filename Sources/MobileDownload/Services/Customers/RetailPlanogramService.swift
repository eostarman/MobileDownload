//
//  File.swift
//  
//
//  Created by Michael Rutherford on 4/27/21.
//

import Foundation

public struct RetailPlanogramService {
    public let customer: CustomerRecord
    let effectiveDate: Date?
    private let customerPlanogram: CustomerRetailPlanogram? // this is what assigns (and schedules) a planogram to a customer
    public let planogram: RetailPlanogramRecord?
    
    private let itemsInRetailLocations: Set<Int>
    private let itemsInPlanogram: Set<Int>
    
    public var hasPlanogram: Bool {
        customerPlanogram != nil
    }
    public var actualResetDate: Date? {
        customerPlanogram?.actualResetDate
    }
    
    private var retailLocations: [RetailerList] {
        customer.retailerInfo.retailLocations
    }
    
    public init(customer: CustomerRecord, today: Date = Date()) {
        self.customer = customer
        guard let customerRetailerPlanogram = Self.getActiveCustomerRetailPlanogram(cusNid: customer.recNid, today: today) else {
            customerPlanogram = nil
            effectiveDate = nil
            planogram = nil
            itemsInRetailLocations = []
            itemsInPlanogram = []
            return
        }
        
        self.customerPlanogram = customerRetailerPlanogram
        effectiveDate = customerRetailerPlanogram.effectiveDate
        let planogram = mobileDownload.retailPlanograms[customerRetailerPlanogram.retailPlanogramNid]
        self.planogram = planogram
        
        itemsInRetailLocations = Set(customer.retailerInfo.retailLocations.flatMap({location in location.getAllItems().map({$0.itemNid})}))
        itemsInPlanogram = Set(planogram.retailPlanogramLocations.flatMap({location in location.retailPlanogramItems.map({$0.itemNid})}))
        
        print("itemsInRetailLocations=\(itemsInRetailLocations)")
        print("itemsInPlanogram=\(itemsInPlanogram)")
        
        print("CUSTOMER=\(Self.getItemNids(customer))")
        print("PLANOGRAM=\(Self.getItemNids(planogram))")
    }
    
    private static func getItemNids(_ customer: CustomerRecord) -> [Int] {
        var itemNids: [Int] = []
        
        for location in customer.retailerInfo.retailLocations {
            itemNids.append(contentsOf: location.getAllItems().map { $0.itemNid} )
        }
        
        return itemNids
    }
    
    private static func getItemNids(_ planogram: RetailPlanogramRecord) -> [Int] {
        var itemNids: [Int] = []
        
        for location in planogram.retailPlanogramLocations {
            itemNids.append(contentsOf: location.retailPlanogramItems.map { $0.itemNid} )
        }
        
        return itemNids
    }
    

    private static func getActiveCustomerRetailPlanogram(cusNid: Int, today: Date) -> CustomerRetailPlanogram? {
        var mostRecentPlanogram: CustomerRetailPlanogram? = nil
        
        for crp in mobileDownload.customerRetailPlanograms {
            if crp.cusNid == cusNid, crp.notifyPresellerDate <= today {
                if mostRecentPlanogram == nil {
                    mostRecentPlanogram = crp
                } else if let mostRecent = mostRecentPlanogram {
                    if crp.notifyPresellerDate > mostRecent.notifyPresellerDate {
                        mostRecentPlanogram = crp
                    } else if crp.notifyPresellerDate == mostRecent.notifyPresellerDate, crp.retailPlanogramNid > mostRecent.retailPlanogramNid {
                        mostRecentPlanogram = crp
                    }
                }
            }
        }
        
        return mostRecentPlanogram
    }
    
    public func getActivationStatusText() -> String? {
        guard let actualResetDate = actualResetDate else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let date = formatter.string(from: actualResetDate)
        return "Activated on \(date))"
    }
    
    public func getDaysRemainingText() -> String? {
        
        guard let effectiveDate = effectiveDate else {
            return nil
        }
        
        let diff = Calendar.current.dateComponents([.day], from: Date(), to: effectiveDate)
        let daysUntilReset = diff.day ?? 0
        
        if daysUntilReset == 0 {
            return "Due today"
        } else if daysUntilReset > 0 {
            if daysUntilReset >= 10 {       // too far in the future to worry about
                return nil
            }
            if daysUntilReset == 1 {
                return "Due tomorrow"
            } else {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                let date = formatter.string(from: effectiveDate)
                return "Due on or before \(date)"
            }
        } else {
            let daysPastDue = -daysUntilReset
            
            if daysPastDue == 1 {
                return "Past due"
            } else {
                
                return "\(daysPastDue) days past due"
            }
        }
    }
    
    public func getDescriptionText() -> String?
    {
        guard let effectiveDate = effectiveDate else {
            return nil
        }
        
        var messages: [String] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        messages.append("Effective on \(dateFormatter.string(from: effectiveDate))")
        
        let addedItemsCount = getAddedItems().count
        if addedItemsCount > 0 {
            if addedItemsCount == 1 {
                messages.append("1 added item")
            } else if addedItemsCount > 1 {
                messages.append("\(addedItemsCount) added items")
            }
        }
        
        let deletedItemsCount = getDeletedItems().count
        if deletedItemsCount > 0 {
            if deletedItemsCount == 1 {
                messages.append("1 deleted item")
            } else if deletedItemsCount > 1 {
                messages.append("\(deletedItemsCount) deleted items")
            }
        }
        
        let description = messages.joined(separator: ", ")
        
        return description
    }
    
    /// Is the item new for this customer (not new for a given location, but new for the whole customer)
    public func isAdded(itemNid: Int) -> Bool {
        !itemsInRetailLocations.contains(itemNid)
    }
    
    public func isDeleted(itemNid: Int) -> Bool {
        !itemsInPlanogram.contains(itemNid)
    }
    
    public func isAddedToThisLocation(itemNid: Int, planogramLocation: RetailPlanogramLocation) -> Bool {
        guard let location = retailerLocation(for: planogramLocation) else {
            return false
        }
        return !location.containsItem(itemNid: itemNid)
    }
    
    /// items that are new for the customer
    public func getAddedItems() -> [ItemRecord] {
        guard planogram != nil else {
            return []
        }
        
        return Array(itemsInPlanogram.subtracting(itemsInRetailLocations))
            .map({mobileDownload.items[$0]})
    }
    
    public func getTotalPar(itemNid: Int) -> Double {
        guard let locations = planogram?.retailPlanogramLocations else {
            return 0
        }
        
        var totalPar = 0.0
        
        for location in locations {
            for item in location.retailPlanogramItems {
                if item.itemNid == itemNid, let par = item.par {
                    totalPar += par
                }
            }
        }
        
        return totalPar
    }
    
    /// items no longer being sold by the customer
    public func getDeletedItems() -> [ItemRecord] {
        guard planogram != nil else {
            return []
        }
        
        return itemsInRetailLocations.subtracting(itemsInPlanogram)
            .map({mobileDownload.items[$0]})
    }

    public func getAddedItems(planogramLocation: RetailPlanogramLocation) -> [RetailPlanogramItem] {
        guard let retailerList = retailerLocation(for: planogramLocation) else {
            return planogramLocation.retailPlanogramItems  // This is a new shelf, so all items are being added.
        }
        
        let itemsOnTheShelf = retailerList.getAllItems()
        let itemsInThePlanogram = planogramLocation.retailPlanogramItems
        
        let itemNidsOnTheShelf = Set(itemsOnTheShelf.map { $0.itemNid })
        
        let addedItems = itemsInThePlanogram.filter({ !itemNidsOnTheShelf.contains($0.itemNid) })

        return addedItems
    }
    
    public func getDeletedItems(planogramLocation: RetailPlanogramLocation) -> [RetailerList.Item] {
        guard let retailerList = retailerLocation(for: planogramLocation) else {
            return []  // This is a new shelf, so no items are being deleted.
        }
        
        let itemsOnTheShelf = retailerList.getAllItems()
        let itemsInThePlanogram = planogramLocation.retailPlanogramItems
        
        let itemNidsInThePlanogram = Set(itemsInThePlanogram.map { $0.itemNid })
 
        let deletedItems = itemsOnTheShelf.filter { !itemNidsInThePlanogram.contains($0.itemNid) }

        return deletedItems
    }

    private func retailerLocation(for planogramLocation: RetailPlanogramLocation) -> RetailerList? {
        retailLocations.first(where: { $0.retailerListTypeNid == planogramLocation.retailerListTypeNid })
    }
    
    public func locationName(_ planogramLocation: RetailPlanogramLocation) -> String {
        if let retailLocation = retailLocations.first(where: { $0.retailerListTypeNid == planogramLocation.retailerListTypeNid }) {
            return retailLocation.description
        } else {
            return mobileDownload.retailerListTypes[planogramLocation.retailerListTypeNid].recName
        }
    }
    
    public func isNewLocation(_ planogramLocation: RetailPlanogramLocation) -> Bool {
        retailerLocation(for: planogramLocation) == nil
    }
    
    /// the par levels by item in a particular location (shelf, cooler, ...)
    private func getPriorParsByItem(planogramLocation: RetailPlanogramLocation) -> [Int: Double] {
        guard let location = retailerLocation(for: planogramLocation) else {
            return [:]
        }
        
        var parsByItem: [Int:Double] = [:]
        
        for item in location.getAllItems() {
            if let par = item.locationPar {
                parsByItem[item.itemNid] = par
            }
        }
        
        return parsByItem
    }
    
    public func getModifiedRetailerInfo() -> RetailerInfo {
        
        let retailerInfo = customer.retailerInfo
        
        return retailerInfo
    }
    
    public func getRetailLocation(cusNid: Int, planogramLocation: RetailPlanogramLocation) -> RetailerList {
        
        let location = RetailerList()
        
        location.cusNid = cusNid
        location.retailerListTypeNid = planogramLocation.retailerListTypeNid
        location.displaySequence = planogramLocation.displaySequence
        location.itemSelection = .AllItems
        location.sectionBy = .NoSections
        location.placementType = .NoPlacementInfo
        location.aisleOrRegisterNumber = nil
        location.isAlphabetical = false
        location.isAutomatic = false
        location.usesRetailerPacks = false
        location.eraseWhenPostingToSQL = false
        location.description = mobileDownload.retailerListTypes[planogramLocation.retailerListTypeNid].recName
        
        let section = RetailerList.Section()
        section.cusNid = cusNid
        section.retailerListTypeNid = planogramLocation.retailerListTypeNid
        section.sectionNumber = 0
        section.sectionBy = .NoSections
        section.sectionRecNid = nil
        section.manualSectionName = nil
        
        location.sections.append(section)
        
        let parsByItem = getPriorParsByItem(planogramLocation: planogramLocation)
        
        var itemDisplaySequence = 0
        for planogramItem in planogramLocation.retailPlanogramItems {
            let item = RetailerList.Item()
            item.cusNid = cusNid
            item.retailerListTypeNid = planogramLocation.retailerListTypeNid

            item.itemNid = planogramItem.itemNid
            item.sectionNumber = 0
            item.displaySequence = itemDisplaySequence
            itemDisplaySequence += 1
            
            if planogramItem.par == nil {
                item.locationPar = parsByItem[item.itemNid]
            } else {
                item.locationPar = planogramItem.par
            }
            
            section.items.append(item)
        }
        
        return location
    }
}
