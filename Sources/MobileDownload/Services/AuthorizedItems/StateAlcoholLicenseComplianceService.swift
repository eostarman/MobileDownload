//
//  StateAlcoholLicenseComplianceService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/3/20.
//

import Foundation

public struct StateAlcoholLicenseComplianceService {
    private var state: StateRecord?
    var customerIsBlacklistedByTheState: Bool = false

    var customerCanBuyAlcohol: Bool = true
    var customerCanBuyNonAlcoholicItems: Bool = true

    init(cusNid: Int) {
        let customer = mobileDownload.customers[cusNid]

        guard let state = mobileDownload.states.getByRecKeyOrNil(customer.shipState) else {
            return
        }

        if let alcoholComplianceHoldCodeNid = state.alcoholComplianceHoldCodeNid {
            customerIsBlacklistedByTheState = state.alcoholComplianceCusNids.contains(cusNid)

            if customerIsBlacklistedByTheState {
                let holdCode = mobileDownload.holdCodes[alcoholComplianceHoldCodeNid]
                if holdCode.noSellFlag {
                    if state.alcoholCompliancePaymentTermsApplyToAlcoholOnly {
                        customerCanBuyAlcohol = false
                    } else {
                        customerCanBuyAlcohol = false
                        customerCanBuyNonAlcoholicItems = false
                    }
                }
            }
        }
    }
}
