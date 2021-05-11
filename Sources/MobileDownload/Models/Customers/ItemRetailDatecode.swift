//
//  File.swift
//  
//
//  Created by Michael Rutherford on 5/10/21.
//

import Foundation

public struct ItemRetailDatecode: Codable {

    public var itemNid: Int = 0
    public var dateCode: Date?
    public var qty: Int?
    public var recordedDate: Date = Date()
    public var empNid: Int = 0
    
    public init() {
    }
    
    public init(itemNid: Int, dateCode: Date?, qty: Int?, recordedDate: Date, empNid: Int) {
        self.itemNid = itemNid
        self.dateCode = dateCode
        self.qty = qty
        self.recordedDate = recordedDate
        self.empNid = empNid
    }
}
