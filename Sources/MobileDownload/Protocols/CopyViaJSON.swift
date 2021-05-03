//
//  File.swift
//  
//
//  Inserted by Michael Rutherford on 5/3/21.
//
//  taken from: https://medium.com/@imthathullah/an-easy-way-to-deep-copy-and-compare-objects-using-codable-in-swift-3095970990e5

import Foundation


public protocol CopyViaJSON: Codable {
    var copy: Self? { get }
}

extension CopyViaJSON {
    public var copy: Self? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}
