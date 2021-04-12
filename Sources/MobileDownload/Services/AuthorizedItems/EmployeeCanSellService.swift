//
//  File.swift
//  
//
//  Created by Michael Rutherford on 4/11/21.
//

import Foundation
import MobileLegacyOrder

public struct EmployeeCanSellService {
    let customer: CustomerRecord
    
    public init(customer: CustomerRecord) {
        self.customer = customer
    }
    
    /// when creating an office list, omit the items the salesperson doesn't normally sell (for example, a wine preseller shouldn't see beer items)
    public func employeeCanAndShouldSellItemToCustomer(item: ItemRecord) -> Bool {
 
        if !employeeCanSell(item: item) {
            return false
        }
       
        if !employeeShouldSell(item: item) {
            return false
        }
        
        return true
    }
    
    
    /// Should the item normally be sold to the customer?
    /// For a Wine Preseller, this will return true for all the wine items, but false for beer.
    public func employeeShouldSell(item: ItemRecord) -> Bool {
        if !isOkayBasedOnProductClassFilter(item: item) {
            return false
        }
        return true
    }
    
    /// Can the handheld employee sell this item to any customer?
    /// This is based on the employee's PresellProductSet, and should be strictly enforced.
    /// Note that you should first do any can-sell filtering that isn't specific to the employee, by using Order.GetSellStatus or similar.
    public func employeeCanSell(item: ItemRecord) -> Bool {
        
        if !isOkayBasedOnPresellProductSet(item: item) {
            return false
        }
        
        let primaryPack = mobileDownload.items[item.altPackFamilyNid]
        if let productClassNid = primaryPack.productClassNid, mobileDownload.productClasses[productClassNid].HasStrictSalesEnforcement {
            
            if !isOkayBasedOnProductClassFilter(item: item) {
                return false
            }
        }
        
        return true
    }
    
    fileprivate func isOkayBasedOnProductClassFilter(item: ItemRecord) -> Bool
    {
        // return nil if there is *no* product class filter; if there *is* a product class filter for *this* customer then return true or false
        if mobileDownload.productClasses.isEmpty {
            return true // no active product classes
        }
        
        // comment below is from legacy HH ... don't know if this is really accurate anymore, but ...
        
        // KJQ 7/24/06 ... there are situations wherein the setup of a customer's service schedule will result in a
        // salesperson having NO product class bits set (e.g. customer has a couple of off-truck salespersons each
        // doing different product classes ... then if you add a pre-seller, there are no product classes left for
        // the pre-seller to handle.  In this case, the pre-load of the invoice from sales history etc. would be
        // "blank"; change here is "If the salesperson has NO product class assignments, then don't apply any
        // filtering.
        
        if  !customer.productClassBit1 &&
                !customer.productClassBit2 &&
                !customer.productClassBit3 &&
                !customer.productClassBit4 &&
                !customer.productClassBit5 &&
                !customer.productClassBit6 &&
                !customer.productClassBit7 &&
                !customer.productClassBit8 &&
                !customer.productClassBit9 &&
                !customer.productClassBit10 {
            return true // handheld assigned employee has no product classes assigned for service of this customer
        }
        
        // product classes are on primary pack so ...
        let primaryPack = mobileDownload.items[item.altPackFamilyNid]
        guard let productClassNid = primaryPack.productClassNid  else {
            return true  // The item is not assigned to any particular product class.
        }
        
        let productClass = productClassNid // the Nid is really an "index" of 1 .. 10
        let isOkayProductClass: Bool
        
        switch productClass {
        case 1: isOkayProductClass = customer.productClassBit1
        case 2: isOkayProductClass = customer.productClassBit2
        case 3: isOkayProductClass = customer.productClassBit3
        case 4: isOkayProductClass = customer.productClassBit4
        case 5: isOkayProductClass = customer.productClassBit5
        case 6: isOkayProductClass = customer.productClassBit6
        case 7: isOkayProductClass = customer.productClassBit7
        case 8: isOkayProductClass = customer.productClassBit8
        case 9: isOkayProductClass = customer.productClassBit9
        case 10: isOkayProductClass = customer.productClassBit10
        default: isOkayProductClass = false
        }
        
        if isOkayProductClass {
            return true
        }
        
        return false // I cannot sell this particular item to the current customer because it's not *my* product class
    }
    
    /// <summary>
    /// Can the item be sold to the customer?
    /// <para>For a Wine Preseller, this might return true even for a beer item, so they can sell a few cases of beer intermittently.</para>
    /// </summary>
    fileprivate func isOkayBasedOnPresellProductSet(item: ItemRecord) -> Bool {
        
        // see ProductSet.cs: GetFilterForItemRecords()
//        switch orderTypeOnMobileDevice {
//        case .Presale, .Offtruck, .OrderRequest, .HotShotOrderRequest:
//            break // Intentionally empty.  These are the types of mobile orders we care about, so we're just avoiding the default case.
//        default:
//            return true
//        }
        
        // return nil if this preseller has no filter listing the items they can sell; otherwise, if there *is* a filter then return true or false.
        guard let presellProductSetNid = mobileDownload.handheld.presellProductSetNid else {
            return true
        }
        
        let productSet = mobileDownload.productSets[presellProductSetNid]
        if productSet.altPackFamilyNids.isEmpty {
            return true
        }
        
        if productSet.altPackFamilyNids.contains(item.altPackFamilyNid) {
            return true
        }
        
        return false // they have a list of items, and this isn't one of the items in that list.
    }
}
