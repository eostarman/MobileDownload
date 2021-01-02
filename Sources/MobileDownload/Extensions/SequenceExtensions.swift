//
//  SequenceExtensions.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 8/29/20.
//
//  https://www.avanderlee.com/swift/unique-values-removing-duplicates-array/

import Foundation

extension Sequence where Iterator.Element: Hashable {
    public func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
