//
//  File.swift
//  
//
//  Created by Michael Rutherford on 4/27/21.
//

import Foundation

/// This is really scheduling (assigning) an actual planogram to a customer. The idea is that we'll notify the preseller when the notifyPresellerDate is "close enough" and we note the effectiveDate (when the planogram "reset"
/// is expected to be done by). When the planogram reset if actually done, we note who did it and when.
public class CustomerRetailPlanogram {
    public init() {}
    
    public var retailPlanogramNid: Int = 0
    public var cusNid: Int = 0
    public var notifyPresellerDate: Date = Date()
    public var effectiveDate: Date = Date()
    public var actualResetDate: Date?
    public var resetByEmpNid: Int?
    
    /// When the merchandiser has reset the shelf to match the planogram, we record who did it and when. So, the reset is complete when the actualResetDate date is set
    public var resetComplete: Bool {
        actualResetDate != nil
    }
}
