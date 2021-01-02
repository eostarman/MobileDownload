//
//  AggregatedSales.swift
//  MobileBench
//
//  Created by Michael Rutherford on 7/24/20.
//

import Foundation
import MoneyAndExchangeRates

public class AggregatedSales {
    public enum ePeriod {
        case Month
    }

    public var salesByPeriod: [DateComponents: AggregatedSale] = [:]

    public class AggregatedSale {
        let dateComponents: DateComponents
        let label: String
        let firstDate: Date

        var sales: [CusItemSale] = []

        init(dateComponents: DateComponents, sale: CusItemSale) {
            let month = Calendar.current.veryShortMonthSymbols[dateComponents.month! - 1]
            self.dateComponents = dateComponents
            label = "\(dateComponents.year!) \(month)"
            firstDate = sale.orderedDate
            sales.append(sale)
        }

        func append(_ sale: CusItemSale) { sales.append(sale) }
    }

    public func getSalesByPeriod() -> [(String, MoneyWithoutCurrency)] {
        var totals: [(String, MoneyWithoutCurrency)] = []

        for sale in salesByPeriod.values {
            let total = sale.sales.reduce(MoneyWithoutCurrency.zero) { x, y in x + y.totalNet }
            totals.append((sale.label, total))
        }

        return totals
    }

    public init(sales: [CusItemSale]) {
        let calendar = Calendar.current

        for sale in sales {
            let dateComponents = calendar.dateComponents([.year, .month], from: sale.orderedDate)

            // print("Aggregate \(sale.orderedDate.toLocalTimeDescription()) \(dateComponents)")

            if let periodSales = salesByPeriod[dateComponents] {
                periodSales.append(sale)
            } else {
                salesByPeriod[dateComponents] = AggregatedSale(dateComponents: dateComponents, sale: sale)
            }
        }
    }
}
