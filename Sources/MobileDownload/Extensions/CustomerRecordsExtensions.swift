//
//  CustomerItemExtensions.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 12/21/20.
//

import Foundation
import MoneyAndExchangeRates

extension Records where T: CustomerRecord {
    /// Return the customer's history of sales These were downloaded from eoStar (in which case the decoder is called) or are loaded directly into the customer record.
    /// I keep the encoded version so I don't have to decode all sales for all downloaded customers as part of the "opening the database" process
    public func getCustomerSales(_ customer: CustomerRecord?) -> [CusItemSale] {
        guard let customer = customer else {
            return []
        }

        if let cusItemSales = customer.cusItemSales {
            return cusItemSales
        }

        if let encodedCusItemSales = customer.encodedCusItemSales {
            guard let decoder = mobileDownload.salesHistoryDecoder else {
                fatalError("Missing salesHistoryDecoder")
            }

            let sales = decoder(customer.recNid, encodedCusItemSales)

//            let sales = CustomerSalesDecoder.decodeSalesHistory(cusNid: customer.recNid, itemHistoryBlob: encodedCusItemSales)
            return sales
        }

        return []
    }
}
