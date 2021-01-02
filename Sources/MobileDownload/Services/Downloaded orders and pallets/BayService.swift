//
//  BayService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/29/20.
//

import Foundation

public class BayService {
    public let bayNumbers: [BayNumber]
    private let allPalletLines: [PalletLine]
    private let palletLinesByBayNumber: [BayNumber: [PalletLine]]
    private let palletLineByPalletID: [String: [PalletLine]]
    private let palletLinesByOrderNumber: [Int: [PalletLine]]
    private let palletLinesByItemNid: [Int: [PalletLine]]
    private let baysByOrderNumber: [Int: [OrderAndBay]]
    private let baysByItemNid: [Int: [ItemAndBay]]

    public struct OrderAndBay: Hashable {
        let orderNumber: Int
        let bayNumber: BayNumber
    }

    public struct ItemAndBay: Hashable {
        let itemNid: Int
        let bayNumber: BayNumber
    }

    public init() {
        bayNumbers = Self.getBayNumbers()

        allPalletLines = mobileDownload.palletLines
            .sorted(by: { $0.completionSeq > $1.completionSeq }) // top to bottom

        palletLinesByBayNumber = Dictionary(grouping: allPalletLines, by: { $0.bayNumber })
        palletLinesByOrderNumber = Dictionary(grouping: allPalletLines, by: { $0.orderNumber })
        palletLinesByItemNid = Dictionary(grouping: allPalletLines, by: { $0.itemNid })
        palletLineByPalletID = Dictionary(grouping: allPalletLines, by: { $0.palletID })

        let baysByOrder = allPalletLines.map { OrderAndBay(orderNumber: $0.orderNumber, bayNumber: $0.bayNumber) }
            .unique()
        baysByOrderNumber = Dictionary(grouping: baysByOrder, by: { $0.orderNumber })

        let baysByItem = allPalletLines.map { ItemAndBay(itemNid: $0.itemNid, bayNumber: $0.bayNumber) }
            .unique()
        baysByItemNid = Dictionary(grouping: baysByItem, by: { $0.itemNid })
    }

    public func palletLines(forBayNumber: BayNumber) -> [PalletLine] {
        if let palletLines = palletLinesByBayNumber[forBayNumber] {
            return palletLines
        }

        return []
    }

    public func bayNumbers(forItemNid: Int) -> [BayNumber] {
        if let bayNumbers = baysByItemNid[forItemNid] {
            return bayNumbers.map { $0.bayNumber }
        }
        return []
    }

    public func bayNumbers(forOrderNumber: Int) -> [BayNumber] {
        if let bayNumbers = baysByOrderNumber[forOrderNumber] {
            return bayNumbers.map { $0.bayNumber }
        }
        return []
    }

    /// all the bay numbers containing product to be delivered for a collection of orders (e.g. for a single customer's orders aka invoices)
    public func bayNumbers(forOrderNumbers orderNumbers: [Int]) -> [BayNumber] {
        var allBayNumbers: [BayNumber] = []

        for orderNumber in orderNumbers {
            allBayNumbers.append(contentsOf: bayNumbers(forOrderNumber: orderNumber))
        }

        allBayNumbers = allBayNumbers.unique()

        return allBayNumbers
    }

    public func palletLines(forOrderNumbers orderNumbers: [Int]) -> [PalletLine] {
        let includedOrders = Set(orderNumbers)
        let palletLines = allPalletLines.filter { includedOrders.contains($0.orderNumber) }
        return palletLines
    }

    public static func getBayNumbers() -> [BayNumber] {
        var bays = mobileDownload.handheld.truckBays.map { BayNumber($0) }
        let palletLines = mobileDownload.palletLines
        let baysWithPalletLines = palletLines.map { $0.bayNumber }.unique()

        bays.append(contentsOf: baysWithPalletLines)

        let allBays = bays.unique()

        return allBays
    }

    public func isKeg(_ itemNid: Int) -> Bool {
        mobileDownload.items[itemNid].isKeg
    }

    public func isFullCase(_ itemNid: Int) -> Bool {
        mobileDownload.items[itemNid].isPrimaryPack()
    }

    public func getDescriptionOfBayContents(bayNumber: BayNumber, palletLines: [PalletLine]) -> [String] {
        var msgs: [String] = []

        if palletLines.isEmpty {
            return ["Empty bay"]
        }

        // the pallet lines are sorted by pick sequence (reversed) so the items will be listed from the top of the pallet to the bottom
        let itemNids = palletLines.map { $0.itemNid }.unique()
        let orderNumbers = palletLines.map { $0.orderNumber }.unique().sorted(by: { $0 < $1 })
        let palletIDs = palletLines.map { $0.palletID }.unique().sorted(by: { $0 < $1 })
        // let nonKegPalletIDs = palletLines.filter({!isKeg($0.itemNid)}).map({$0.palletID}).unique().sorted(by: {$0 < $1})
        let kegs = palletLines.filter { isKeg($0.itemNid) }.reduce(0) { $0 + $1.qty }
        let cases = palletLines.filter { !isKeg($0.itemNid) && isFullCase($0.itemNid) }.reduce(0) { $0 + $1.qty }
        let units = palletLines.filter { !isKeg($0.itemNid) && !isFullCase($0.itemNid) }.reduce(0) { $0 + $1.qty }

        for palletID in palletIDs {
            msgs.append("Pallet \(palletID)")
        }

        for orderNumber in orderNumbers {
            if let otherBays = baysByOrderNumber[orderNumber]?.filter({ $0.bayNumber != bayNumber }) {
                if !otherBays.isEmpty {
                    let others = otherBays.map { $0.bayNumber.name }.joined(separator: ", ")
                    msgs.append("Order #\(orderNumber) also in \(others)")
                    continue
                }
            }
            msgs.append("Order #\(orderNumber)")
        }

        var msgParts: [String] = []

        // if nonKegPalletIDs.count > 0 {
        //     msgParts.append(nonKegPalletIDs.count == 1 ? "1 pallet" : "\(nonKegPalletIDs.count) pallets")
        // }
        if orderNumbers.count > 0 {
            msgParts.append(orderNumbers.count == 1 ? "1 order" : "\(orderNumbers.count) orders")
        }
        if itemNids.count > 0 {
            msgParts.append(itemNids.count == 1 ? "1 item" : "\(itemNids.count) items")
        }
        if kegs > 0 {
            msgParts.append(kegs == 1 ? "1 keg" : "\(kegs) kegs")
        }
        if cases > 0 {
            msgParts.append(cases == 1 ? "1 case" : "\(cases) cases")
        }
        if units > 0 {
            msgParts.append(units == 1 ? "1 unit" : "\(units) units")
        }

        let msg = msgParts.joined(separator: ", ")

        msgs.append(msg)

        return msgs
    }
}
