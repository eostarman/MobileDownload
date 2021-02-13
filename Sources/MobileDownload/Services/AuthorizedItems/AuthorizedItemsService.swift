//
//  AuthorizedItemService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/3/20.
//
// determine whether or not a customer is authorized to buy an item (from a warehouse on a given date)

import Foundation

public class AuthorizedItemsService {
    let fromWhseNid: Int
    let cusNid: Int
    let customer: CustomerRecord
    let shipDate: Date

    let warehouseCanSellService: WarehouseCanSellService
    let blacklistedItemsService: BlacklistedItemsService
    let stateAlcoholLicenseComplianceService: StateAlcoholLicenseComplianceService
    let companyBlacklistService: CompanyBlacklistService
    let multiCompanyService: MultiCompanyService
    let itemAllocationService: CusAllocationsService
    let customerAuthorizedItemsService: CustomerAuthorizedItemsService
    let brandFamilyCanBuyRestrictionsService: BrandFamilyCanBuyRestrictionsService
    let liquorLicenseService: LiquorLicenseService
    let permitService: PermitService

    let checkLiquorLicenseAndPermitRestrictions = true
    let isBeerWinePluginInstalled: Bool

    public init(fromWhseNid: Int, cusNid: Int, shipDate: Date) {
        self.fromWhseNid = fromWhseNid
        self.cusNid = cusNid
        customer = mobileDownload.customers[cusNid]
        self.shipDate = shipDate

        isBeerWinePluginInstalled = mobileDownload.handheld.requiresBeerWinePluginSupport

        warehouseCanSellService = WarehouseCanSellService(whseNid: fromWhseNid)
        blacklistedItemsService = BlacklistedItemsService(cusNid: cusNid)
        stateAlcoholLicenseComplianceService = StateAlcoholLicenseComplianceService(cusNid: cusNid)
        companyBlacklistService = CompanyBlacklistService(customer: customer)
        multiCompanyService = MultiCompanyService(whseNid: fromWhseNid)
        itemAllocationService = CusAllocationsService(cusNid: cusNid, whseNid: fromWhseNid, shipDate: shipDate)
        customerAuthorizedItemsService = CustomerAuthorizedItemsService(cusNid: cusNid)
        brandFamilyCanBuyRestrictionsService = BrandFamilyCanBuyRestrictionsService(cusNid: cusNid)
        liquorLicenseService = LiquorLicenseService(cusNid: cusNid)
        permitService = PermitService(cusNid: cusNid)
    }
    
    public func isAuthorized(itemNid: Int) -> Bool {
        getAuthorizedItemStatus(itemNid: itemNid) == .OK
    }

    public func getAuthorizedItemStatus(itemNid: Int) -> AuthorizedItemStatus {
        if !customer.activeFlag {
            return .ErasedCustomer
        }

        if itemNid == 0 { // note line
            return .OK
        }

        let item = mobileDownload.items[itemNid]

        if !item.activeFlag {
            return .ErasedItem
        }

        if !warehouseCanSellService.isListedInWarehousesSellableItems(itemNid: itemNid) {
            return .NotInWarehouseSellableProductSet
        }

        if !item.canSell {
            return .NoCanSell
        }

        if !warehouseCanSellService.canSell(itemNid: itemNid) {
            return .UnsellableForWarehouse
        }

        let brand = item.brandNid == nil ? nil : mobileDownload.brands[item.brandNid!]

        if blacklistedItemsService.isBrandBlacklistedInCounty(brandNid: item.brandNid) {
            return .CountyBlacklisted
        }

        if blacklistedItemsService.isBlacklistedForCustomerSalesChannelOrChain(altPackFamilyNid: item.altPackFamilyNid) {
            return .Blacklisted
        }

        if item.isAlcohol, !stateAlcoholLicenseComplianceService.customerCanBuyAlcohol {
            return .NoSellAlcoholStateNonCompliance
        }

        if companyBlacklistService.whichCompaniesAreBlocked != .NoCompaniesAreBlocked {
            if companyBlacklistService.whichCompaniesAreBlocked == .AllCompaniesAreBlocked {
                return .NoSellHoldCode
            }

            let companyNid = multiCompanyService.getCompanyNid(altPackFamilyNid: item.altPackFamilyNid)
            let company = mobileDownload.companies[companyNid]
            if companyBlacklistService.isCompanyBlocked(company: company) {
                return .NoSellHoldCode
            }
        }

        if item.isRedBull, customer.isOffPremise, mobileDownload.handheld.noRedBullSalesToOffPremiseAccounts {
            return .NoRedBullSalesToOffPremiseAccounts
        }

        if item.isPart || item.isBillingCode || item.isTapHandle || item.isPOS || item.isEmpty || item.isRawGoods || item.isGas {
            return .OK
        }

        // strictly disallow sale if the item is sold via allocation only and the customer has
        // no allocation (I don't check whether or not the allocation is "expired" or "not yet started"
        // or "used up" currently)

        if item.sellOnlyViaAllocations {
            if !itemAllocationService.hasAllocation(itemNid: itemNid) {
                return .AllocationRestriction
            }
        }

        let privateLabelChainNid = brand?.privateLabelChainNid ?? 0

        if privateLabelChainNid > 0 {
            if customer.chainNid != privateLabelChainNid {
                return .PrivateLabelRestriction
            }
        } else {
            if !customerAuthorizedItemsService.isAuthorizedToBuy(itemNid: itemNid) {
                return .UnauthorizedItem
            }

            if isBeerWinePluginInstalled, !item.ignoresBrandFamilyCanBuyRestriction {
                let brandFamilyNid = brand?.brandFamilyNid ?? 0

                if brandFamilyNid > 0 {
                    if !brandFamilyCanBuyRestrictionsService.isAllowedForCustomer(brandFamilyNid: brandFamilyNid) {
                        return .UnauthorizedItemNotInCustomersBrandFamilies
                    }

                    if !brandFamilyCanBuyRestrictionsService.isAllowedForTerritory(brandFamilyNid: brandFamilyNid) {
                        return .UnauthorizedItemNotInTerritorysBrandFamilies
                    }
                }
            }
        }

        if checkLiquorLicenseAndPermitRestrictions, item.isAlcohol {
            if liquorLicenseService.isAddingAlcoholItemWithExpiredLiquorLicense(customer: customer, shipDate: shipDate) {
                return .MissingLiquorLicense
            }

            if liquorLicenseService.isAddingAlcoholItemWithExpiredLiquorLicense(customer: customer, shipDate: shipDate) {
                return .ExpiredLiquorLicense
            }

            let permitStatus = permitService.getPermitStatus(altPackFamilyNid: item.altPackFamilyNid, shipDate: shipDate)
            if permitStatus != .OK {
                return permitStatus
            }
        } else {
            let permitStatus = permitService.getPermitStatus(altPackFamilyNid: item.altPackFamilyNid, shipDate: shipDate)
            if permitStatus != .NoPermit {
                return permitStatus
            }
        }

        if item.isAlcohol {
            if let brandNid = item.brandNid {
                let brand = mobileDownload.brands[brandNid]

                if !customer.mayBuyStrongBeer, brand.isStrongBeer {
                    return .CannotBuyStrongBeer
                }

                if !customer.mayBuyWine, brand.isWine {
                    return .CannotBuyWine
                }
            }
        }

        return .OK
    }
}
