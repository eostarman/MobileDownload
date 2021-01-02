//
//  CompanyBlacklistService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/3/20.
//
//
// if a customer has a hold-code for one company, they can still buy from the other company (Frank Beer/Liqour)

import Foundation

public struct CompanyBlacklistService {
    enum WhichCompaniesAreBlocked {
        case NoCompaniesAreBlocked
        case AllCompaniesAreBlocked
        case CompaniesInReceivablesGroup1AreBlocked
        case CompaniesInReceivablesGroup2AreBlocked
    }

    let whichCompaniesAreBlocked: WhichCompaniesAreBlocked

    func isCompanyBlocked(company: CompanyRecord) -> Bool {
        switch whichCompaniesAreBlocked {
        case .AllCompaniesAreBlocked:
            return true
        case .NoCompaniesAreBlocked:
            return false
        case .CompaniesInReceivablesGroup1AreBlocked:
            return company.receivablesGroup == 1
        case .CompaniesInReceivablesGroup2AreBlocked:
            return company.receivablesGroup == 2
        }
    }

    init(customer: CustomerRecord) {
        // look at c# MobileCache.GetNoSellCompanyNids()
        let holdCodeNid1 = customer.holdCodeNid
        let holdCodeNid2 = customer.holdCodeNid2

        // we allow 2 receivable groups (really arbitrary)
        if mobileDownload.handheld.useReceivableGroups {
            let noSellFlag1 = holdCodeNid1 != nil && mobileDownload.holdCodes[holdCodeNid1!].noSellFlag
            let noSellFlag2 = holdCodeNid2 != nil && mobileDownload.holdCodes[holdCodeNid2!].noSellFlag

            if noSellFlag1, noSellFlag2 {
                whichCompaniesAreBlocked = .AllCompaniesAreBlocked
            } else if noSellFlag1 {
                whichCompaniesAreBlocked = .CompaniesInReceivablesGroup1AreBlocked
            } else if noSellFlag2 {
                whichCompaniesAreBlocked = .CompaniesInReceivablesGroup2AreBlocked
            } else {
                whichCompaniesAreBlocked = .NoCompaniesAreBlocked
            }
        } else {
            let noSellFlag = holdCodeNid1 != nil && mobileDownload.holdCodes[holdCodeNid1!].noSellFlag

            if noSellFlag {
                whichCompaniesAreBlocked = .AllCompaniesAreBlocked
            } else {
                whichCompaniesAreBlocked = .NoCompaniesAreBlocked
            }
        }
    }
}
