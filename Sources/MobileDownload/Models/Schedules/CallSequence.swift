//
//  DailyCallSchedule.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 9/10/20.
//

import Foundation

/// List of customers in sequence for a given day. ScheduleSequences in c#
public struct CallSequence {
    public let dateOrDayOfTheWeek: Int
    public let cusNidsInSequence: [Int]

    public init(dateOrDayOfTheWeek: Int, cusNidsInSequence: [Int]) {
        self.dateOrDayOfTheWeek = dateOrDayOfTheWeek
        self.cusNidsInSequence = cusNidsInSequence
    }

    public var isEmpty: Bool { cusNidsInSequence.isEmpty }

    static var emptySequence: CallSequence = .init(dateOrDayOfTheWeek: 0, cusNidsInSequence: [])
}
