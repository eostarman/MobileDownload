//
//  LiquorLicenseService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/4/20.
//

import Foundation

public struct LiquorLicenseService {
    let strictLiquorLicenseEnforcement: Bool
    let gracePeriod: Int

    init(cusNid _: Int) {
        strictLiquorLicenseEnforcement = mobileDownload.handheld.strictLiquorLicenseEnforcement
        gracePeriod = mobileDownload.handheld.liquorLicenseExpirationGracePeriod
    }

    func isAddingAlcoholItemWithMissingLiquorLicense(customer: CustomerRecord, shipDate _: Date) -> Bool {
        customer.liquorLicenseNumber.isEmpty
    }

    func isAddingAlcoholItemWithExpiredLiquorLicense(customer: CustomerRecord, shipDate: Date) -> Bool {
        if !strictLiquorLicenseEnforcement {
            return false
        }

        if var expirationDate = customer.liquorLicenseExpirationDate {
            if customer.hasExpirationGracePeriod, gracePeriod > 0 {
                expirationDate = Calendar.current.date(byAdding: .day, value: gracePeriod, to: expirationDate)!
            }

            if shipDate > expirationDate {
                return true
            }
        }

        return false
    }
}
