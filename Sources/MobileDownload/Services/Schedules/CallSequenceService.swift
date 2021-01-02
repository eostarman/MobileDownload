//
//  DailyCallScheduleService.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 9/10/20.
//

import Foundation

public struct CallSequenceService {
    public static func getCallSequence(date: Date) -> CallSequence {
        guard let yyyyMMdd = Int(date.toLocalTime_yyyyMMdd()) else {
            return CallSequence.emptySequence
        }

        let dow = Calendar.current.dateComponents([.weekday], from: date)
        let weekday = dow.weekday ?? 1 // 1=Sunday (just like SQL)  https://developer.apple.com/documentation/foundation/nsdatecomponents/1410442-weekday

        let callSequences = mobileDownload.callSequences
        if let sequenceForSpecificDate = callSequences.filter({ $0.dateOrDayOfTheWeek == yyyyMMdd }).first {
            return sequenceForSpecificDate
        }
        if let sequenceForDayOfTheWeek = callSequences.filter({ $0.dateOrDayOfTheWeek == weekday }).first {
            return sequenceForDayOfTheWeek
        }
        if let genericSequence = callSequences.filter({ $0.dateOrDayOfTheWeek == 0 }).first {
            return genericSequence
        }
        return CallSequence.emptySequence
    }
}
