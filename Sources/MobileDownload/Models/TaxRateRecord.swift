//
//  TaxRateRecord.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 12/23/20.
//

import Foundation

// not a "real" Record (with a recNid, recKey and recName)
public class TaxRateRecord {
    public var taxAreaNid: Int = 0
    public var taxClassNid: Int = 0

    public var stateEffectiveDate: Date?
    public var countyEffectiveDate: Date?
    public var cityEffectiveDate: Date?
    public var localEffectiveDate: Date?
    public var wholesaleEffectiveDate: Date?
    public var vatEffectiveDate: Date?
    public var levyEffectiveDate: Date?

    public var stateSupercededDate: Date?
    public var countySupercededDate: Date?
    public var citySupercededDate: Date?
    public var localSupercededDate: Date?
    public var wholesaleSupercededDate: Date?
    public var vatSupercededDate: Date?
    public var levySupercededDate: Date?

    public var stateEffectivePct: Double = 0
    public var countyEffectivePct: Double = 0
    public var cityEffectivePct: Double = 0
    public var localEffectivePct: Double = 0
    public var wholesaleEffectivePct: Double = 0
    public var vatEffectivePct: Double = 0
    public var levyEffectivePct: Double = 0

    public var stateSupercededPct: Double = 0
    public var countySupercededPct: Double = 0
    public var citySupercededPct: Double = 0
    public var localSupercededPct: Double = 0
    public var wholesaleSupercededPct: Double = 0
    public var vatSupercededPct: Double = 0
    public var levySupercededPct: Double = 0

    // Tax schedule stuff filled in when the TaxSchedulePlugin is installed
    public var stateTaxScheduleNid: Int?
    public var countyTaxScheduleNid: Int?
    public var cityTaxScheduleNid: Int?
    public var localTaxScheduleNid: Int?
    public var wholesaleTaxScheduleNid: Int?
    public var vATScheduleNid: Int?
    public var levyScheduleNid: Int?

    public var stateSupercededTaxScheduleNid: Int?
    public var countySupercededTaxScheduleNid: Int?
    public var citySupercededTaxScheduleNid: Int?
    public var localSupercededTaxScheduleNid: Int?
    public var wholesaleSupercededTaxScheduleNid: Int?
    public var vatSupercededTaxScheduleNid: Int?
    public var levySupercededTaxScheduleNid: Int?

    public var isPct: Bool = false
    public var isRatePerGallon: Bool = false
    public var isRatePerLiter: Bool = false
    public var isPctOfMTV: Bool = false

    public init() { }
}
