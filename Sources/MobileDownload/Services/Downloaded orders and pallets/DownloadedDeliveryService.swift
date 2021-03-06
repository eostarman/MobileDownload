//
//  DownloadedDeliveryService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/29/20.
//

import Foundation
import MobileLegacyOrder

public class DownloadedDeliveryService {
    private lazy var deliveriesInSequence: [LegacyOrder] = mobileDownload.deliveries.getAll().map { $0.order }
        .sorted(by: { $0.deliverySequence ?? 0 < $1.deliverySequence ?? 0 })

    public init() { }
    
    public func getDownloadedDeliveries() -> [LegacyOrder] {
        return deliveriesInSequence
    }

    public var numberOfDeliveryStops: Int {
        let cusNids = deliveriesInSequence.map { $0.toCusNid }.unique()
        return cusNids.count
    }

    /// All cusNids with deliveries downloaded from eoStar
    public func getCustomersInDeliverySequence() -> [CustomerRecord] {
        let cusNids = deliveriesInSequence.map { $0.toCusNid }.unique()
        let customers = cusNids.map { mobileDownload.customers[$0] }
        return customers
    }

    public func getDeliveriesForCustomer(cusNid: Int) -> [LegacyOrder] {
        let deliveries = deliveriesInSequence.filter { $0.toCusNid == cusNid }
        return deliveries
    }

    public func getOrderNumbersForCustomer(cusNid: Int) -> [Int] {
        let orderNumbers = deliveriesInSequence.filter { $0.toCusNid == cusNid }.map { $0.orderNumber ?? 0 }.unique() // I'm not expecting a download-delivery to be missing an order number, but ...
        return orderNumbers
    }
}
