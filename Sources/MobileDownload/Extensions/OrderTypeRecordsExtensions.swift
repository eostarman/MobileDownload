//
//  OrderTypeRecordExtensions.swift
//  MobileBench
//
//  Created by Michael Rutherford on 8/18/20.
//

import Foundation

extension Records where T: OrderTypeRecord {
    public func getOrderTypesForSamples() -> [OrderTypeRecord] {
        getOrderTypesForMobileUsers().filter { $0.isForSamples && !$0.isBillAndHold }
    }

    public func getOrderTypesForOrders() -> [OrderTypeRecord] {
        return getOrderTypesForMobileUsers().filter { !$0.isForPOS && !$0.isForSamples }
    }

    public func getOrderTypesForOrders(includeHotShot: Bool) -> [OrderTypeRecord] {
        var orderTypes = getOrderTypesForOrders()

        if includeHotShot {
            orderTypes.append(contentsOf: getAll().filter { $0.isHotshotFlag && !$0.excludeFromUseOnMobileDevices })
        }

        return orderTypes
    }

    public func getOrderTypesForPOSRequests() -> [OrderTypeRecord] {
        getOrderTypesForMobileUsers().filter { $0.isForPOS && !$0.isBillAndHold && $0.recNid != mobileDownload.handheld.posRemovalsOrderTypeNid }
    }

    public func GetOrderTypeDefaultForSamples() -> Int? {
        getOrderTypesForSamples().first?.recNid
    }

    public func getOrderTypesForMobileUsers() -> [OrderTypeRecord] {
        // some order types are appropriate only in eoStar, not on a mobile device
        return getAll().filter { x in !x.isHotshotFlag && !x.isForCumulativePromotions && x.recNid != mobileDownload.handheld.webOrderTypeNid && !x.excludeFromUseOnMobileDevices }
    }
}
