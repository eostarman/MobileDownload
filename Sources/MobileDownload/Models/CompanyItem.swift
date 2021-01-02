//
//  CompanyItem.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 12/16/20.
//

import Foundation

/// Define which company "owns" an item. If the company owns the whole warehouse, then it owns all items *in* that warehouse; if the company owns certain product (e.g. all liquor items may be owned
/// by one company separate from the company that owns all of the other items.
public struct CompanyItem: Codable {
    public var companyNid: Int
    public var hostWhseNid: Int? // a warehouse has related trucks and drop-points. WhseNid refers to the warehouse; hostWhseNid captures the warehouse, trucks and drop points
    public var productSetNid: Int? // all items listed in this product set (the product set contains altPackFamilyNids but all alt-packs are implied) are owned by the company

    public init() {
        companyNid = 0
    }
}
