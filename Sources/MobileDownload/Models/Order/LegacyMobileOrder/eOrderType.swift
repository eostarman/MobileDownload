//
//  eOrderType.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/31/20.
//

extension MobileOrder {
    public enum eOrderType: Int, Codable {
        case FreshPresellOrder = 0
        case FreshOfftruckOrder = 1
        case DeliveryOfDownloadedOrder = 2
        case DownloadedOrderToBeDelivered = 3
        case OrderToPick = 4
        case OrderToPickAndDeliver = 5
        case OrderRequest = 6
    }
}
