//
//  MultiCompanyInventoryService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/3/20.
//
// multiple companies can own parts of the inventory available (a whole warehouse, individual items or by a combination)
// see c# MobileCache/CompanyItems.cs

import Foundation

/// Determine which company owns an item that's in a given warehouse
public struct MultiCompanyService {
    let whseNid: Int
    let rules: [Rule]
    let whseCompanyNid: Int

    /// This rule is just a copy of the CompanyItem stucture, but with the productSetNid mapped to the product set's set of altPackFamilyNids
    struct Rule {
        var companyNid: Int
        var hostWhseNid: Int? // a warehouse has related trucks and drop-points. WhseNid refers to the warehouse; hostWhseNid captures the warehouse, trucks and drop points
        var altPackFamilyNids: Set<Int>? // all items listed in this product set (the product set contains altPackFamilyNids but all alt-packs are implied) are owned by the company

        init(ci: CompanyItem) {
            companyNid = ci.companyNid
            hostWhseNid = ci.hostWhseNid
            if let productSetNid = ci.productSetNid {
                altPackFamilyNids = mobileDownload.productSets[productSetNid].altPackFamilyNids
            } else {
                altPackFamilyNids = nil
            }
        }

        /// get the matchLevel for this whseNid. If this rule is for a different warehouse, then return nil; if the rule is for only some items, then return nil.
        /// - Parameter whseNid: the warehouse we're selling from
        /// - Returns: 2 if this rule is specifying the companyNid for this specific warehouse; 1 if the rule is a "default" for "any" warehouse (nil otherwise)
        func getMatchLevel(whseNid: Int) -> Int? {
            let hasWhseNid: Bool

            if let hostWhseNid = hostWhseNid {
                if hostWhseNid != whseNid {
                    return nil
                }
                hasWhseNid = true
            } else {
                hasWhseNid = false
            }

            if altPackFamilyNids != nil {
                return nil
            }

            return hasWhseNid ? 2 : 1
        }

        /// get the matchLevel for the altPackFamilyNid in a particular warehous. Ignore the rule if the rule is for a different wareouse or for other items, but not this one (return nil)
        /// Otherwise,
        /// - Parameters:
        ///   - whseNid: the warehouse we're selling from
        ///   - altPackFamilyNid: the primary pack (all alt-packs are treated the same way)
        /// - Returns: matchLevel of from 1 to 4 (or nil)
        func getMatchLevel(whseNid: Int, altPackFamilyNid: Int) -> Int? {
            let hasWhseNid: Bool
            let hasProductSet: Bool

            if let hostWhseNid = hostWhseNid {
                if hostWhseNid != whseNid {
                    return nil
                }
                hasWhseNid = true
            } else {
                hasWhseNid = false
            }

            if let altPackFamilyNids = altPackFamilyNids {
                if !altPackFamilyNids.contains(altPackFamilyNid) {
                    return nil
                }
                hasProductSet = true
            } else {
                hasProductSet = false
            }

            if hasProductSet {
                return hasWhseNid ? 4 : 3
            } else {
                return hasWhseNid ? 2 : 1
            }
        }
    }

    init(whseNid: Int) {
        self.whseNid = whseNid

        let handheld = mobileDownload.handheld

        if !handheld.isMultiCompanyPluginInstalled {
            rules = []
            whseCompanyNid = 1
            return
        }

        rules = handheld.companyItems.map { Rule(ci: $0) }

        if rules.isEmpty {
            whseCompanyNid = mobileDownload.warehouses[whseNid].companyNid ?? 1
            return
        }

        // 1. If WhseNid is =0 and ProductSetNid is =0  then this is the default company for all items in any warehouse
        // 2. If WhseNid is >0 and ProductSetNid is =0, then this is the company for all items sold in that warehouse
        // 3. If WhseNid is =0 and ProductSetNid is >0, then this is the company for only these items in any warehouse
        // 4. If WhseNid is >0 and ProductSetNid is >0  then this is the company for only these items in that warehouse
        //     (or sold from that warehouse, or purchased into that warehouse, or transferred from or to that warehouse).
        //
        // Order of precedence:
        // If (4) matches, then we’re done; otherwise, if (3) matches then we’re done; otherwise, if (2) matches then we’re done; finally, (1) kicks in.

        var companyNid = mobileDownload.warehouses[whseNid].companyNid
        var bestMatchLevel = 0

        for rule in rules {
            if let matchLevel = rule.getMatchLevel(whseNid: whseNid) {
                if matchLevel > bestMatchLevel {
                    bestMatchLevel = matchLevel
                    companyNid = rule.companyNid
                }
            }
        }

        whseCompanyNid = companyNid ?? 1
    }

    func getCompanyNid(altPackFamilyNid: Int) -> Int {
        var companyNid = whseCompanyNid
        var bestMatchLevel = 0

        for rule in rules {
            if let matchLevel = rule.getMatchLevel(whseNid: whseNid, altPackFamilyNid: altPackFamilyNid) {
                if matchLevel > bestMatchLevel {
                    bestMatchLevel = matchLevel
                    companyNid = rule.companyNid
                }
            }
        }

        return companyNid
    }
}
