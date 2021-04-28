//
//  File.swift
//  
//
//  Created by Michael Rutherford on 4/27/21.
//

import Foundation

public struct RetailPlanogramService {
    public static func getActiveCustomerRetailPlanogram(cusNid: Int, today: Date) -> CustomerRetailPlanogram? {
        var mostRecentPlanogram: CustomerRetailPlanogram? = nil
        
        for planogram in mobileDownload.customerRetailPlanograms {
            if planogram.cusNid == cusNid, planogram.notifyPresellerDate <= today {
                if mostRecentPlanogram == nil {
                    mostRecentPlanogram = planogram
                } else if let mostRecent = mostRecentPlanogram {
                    if planogram.notifyPresellerDate > mostRecent.notifyPresellerDate {
                        mostRecentPlanogram = planogram
                    } else if planogram.notifyPresellerDate == mostRecent.notifyPresellerDate, planogram.retailPlanogramNid > mostRecent.retailPlanogramNid {
                        mostRecentPlanogram = planogram
                    }
                }
            }
        }
        
        return mostRecentPlanogram
    }
    
    public static func getActivationStatusText(actualResetDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let date = formatter.string(from: actualResetDate)
        return "Activated on \(date))"
    }
    
    public static func getDaysRemainingText(customerPlanogram: CustomerRetailPlanogram) -> String? {

        let diff = Calendar.current.dateComponents([.day], from: Date(), to: customerPlanogram.effectiveDate)
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
                let date = formatter.string(from: customerPlanogram.effectiveDate)
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
    
    public static func getDescriptionText(customerPlanogram: CustomerRetailPlanogram, retailerInfo: RetailerInfo) -> String
    {
        let planogram = mobileDownload.retailPlanograms[customerPlanogram.retailPlanogramNid]
        
        var messages: [String] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        messages.append("Effective on \(dateFormatter.string(from: customerPlanogram.effectiveDate))")
        
        let addedItemsCount = getAddedItems(planogram: planogram, retailerLists: retailerInfo.retailLocations).count
        if addedItemsCount > 0 {
            if addedItemsCount == 1 {
                messages.append("1 added item")
            } else if addedItemsCount > 1 {
                messages.append("\(addedItemsCount) added items")
            }
        }
        
        let deletedItemsCount = getDeletedItems(planogram: planogram, retailerLists: retailerInfo.retailLocations).count
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
    
    public static func getAddedItems(planogram: RetailPlanogramRecord, retailerLists: [RetailerList]) -> [RetailPlanogramItem] {
        
        var allAddedItems: [RetailPlanogramItem] = []
        
        for planogramLocation in planogram.retailPlanogramLocations {
            if let retailerList = getMatchingRetailerList(retailerLists: retailerLists, retailerListTypeNid: planogramLocation.retailerListTypeNid) {
                allAddedItems.append(contentsOf: getAddedItems(planogramLocation: planogramLocation, retailerList: retailerList))
            } else {
                allAddedItems.append(contentsOf: planogramLocation.retailPlanogramItems) // This is a new shelf, so all items are being added.
            }
        }
        
        return allAddedItems
    }
    
    public static func getAddedItems(planogramLocation: RetailPlanogramLocation, retailerList: RetailerList) -> [RetailPlanogramItem]    {
        let existingItemNids = Set(retailerList.getAllItems().map { $0.itemNid })
        return planogramLocation.retailPlanogramItems.filter({ !existingItemNids.contains($0.itemNid) })
    }
    
    public static func getDeletedItems(planogram: RetailPlanogramRecord, retailerLists: [RetailerList]) -> [RetailerList.Item] {
        
        var allDeletedItems: [RetailerList.Item] = []
        
        for planogramLocation in planogram.retailPlanogramLocations {
            if let retailerList = getMatchingRetailerList(retailerLists: retailerLists, retailerListTypeNid: planogramLocation.retailerListTypeNid) {
                allDeletedItems.append(contentsOf: getDeletedItems(planogramLocation: planogramLocation, retailerList: retailerList))
            }
        }
        
        return allDeletedItems
    }
    
    public static func getDeletedItems(planogramLocation: RetailPlanogramLocation, retailerList: RetailerList) -> [RetailerList.Item] {
        let planogramItemNids = Set( planogramLocation.retailPlanogramItems.map { $0.itemNid })
        return retailerList.getAllItems().filter { listItem in !planogramItemNids.contains(listItem.itemNid) }
    }
    
    public static func getMatchingPlanogramLocation(planogramLocations: [RetailPlanogramLocation],  retailerList: RetailerList) -> RetailPlanogramLocation? {
        planogramLocations.first(where: { $0.retailerListTypeNid == retailerList.retailerListTypeNid})
    }
    
    public static func getMatchingRetailerList(retailerLists: [RetailerList], retailerListTypeNid: Int) -> RetailerList? {
        retailerLists.first(where: { $0.retailerListTypeNid == retailerListTypeNid })
    }
}
