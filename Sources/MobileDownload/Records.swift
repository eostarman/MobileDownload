//
//  Records.swift
//  MobileBench
//
//  Created by Michael Rutherford on 7/13/20.
//

import Foundation

public final class Records<T: Record> {
    private var recordsByRecNid: [Int: T]

    public var count: Int { recordsByRecNid.count }
    public var isEmpty: Bool { recordsByRecNid.isEmpty }

    private var _allRecordsSorted: [T]?
    private var _recNidsByRecKey: [String: Int]?
    
    private var mockRecNid = 0

    init() {
        recordsByRecNid = [:]
    }

    public init(_ records: [T]) {
        recordsByRecNid = Dictionary(uniqueKeysWithValues: records.map { ($0.recNid, $0) })
    }

    @discardableResult
    public func add(_ record: T) -> T {
        recordsByRecNid[record.recNid] = record

        _allRecordsSorted = nil
        _recNidsByRecKey = nil

        return record
    }
    
    private func getMockRecNid() -> Int {
        while true {
            mockRecNid += 1
            
            if recordsByRecNid[mockRecNid] != nil {
                continue
            }
            
            // use the brute-force search so we don't create any lazy dictionaries
            if recordsByRecNid.values.contains(where: { $0.recKey == String(mockRecNid) }) {
                continue
            }
            
            return mockRecNid
        }
    }
    
    /// add a new record for mocking up data for UI testing
    public func addMock(recName: String) -> T {
        let recNid = getMockRecNid()
        var record = T.init()
        record.recNid = recNid
        record.recKey = String(recNid)
        record.recName = recName
        
        return add(record)
    }

    public subscript(_ recKey: String) -> T? {
        if _recNidsByRecKey == nil {
            _recNidsByRecKey = Dictionary(uniqueKeysWithValues: getAll().map { ($0.recKey, $0.recNid) })
        }

        guard let recNid = _recNidsByRecKey![recKey] else {
            return nil
        }

        let record = recordsByRecNid[recNid]
        return record
    }

    public func getAll() -> [T] {
        if let allRecordsSorted = _allRecordsSorted {
            return allRecordsSorted
        } else {
            let allRecordsSorted = recordsByRecNid.values.sorted(by: { $0.recName < $1.recName })
            _allRecordsSorted = allRecordsSorted
            return allRecordsSorted
        }
    }

    public func findByName(recName: String) -> [T] {
        if recName.isEmpty {
            return getAll()
        }

        return getAll().filter { $0.recName.localizedCaseInsensitiveContains(recName) }
    }

    public subscript(_ recNid: Int) -> T {
        if let record = recordsByRecNid[recNid] {
            return record
        }

        var missing = T()
        missing.recNid = recNid
        missing.recKey = "#\(recNid)#"
        missing.recName = "Not downloaded"
        print("ERROR: RECNID \(recNid) is not downloaded")
        return missing
    }

    public func getRecKey(_ recNid: Int) -> String {
        self[recNid].recKey
    }

    public func getRecName(_ recNid: Int) -> String {
        self[recNid].recName
    }
}
