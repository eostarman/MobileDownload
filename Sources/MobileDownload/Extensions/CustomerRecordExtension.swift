//
//  CustomerRecordExtension.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 9/3/20.
//

import Foundation
import MapKit

extension CustomerRecord {
    public var hasMapLocation: Bool {
        shipLatitude != nil && shipLongitude != nil
    }

    public var mapLocation: CLLocationCoordinate2D? {
        if let latitude = shipLatitude, let longitude = shipLongitude {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            return nil
        }
    }
    
    /// use this to allow voice command for customer names displayed on (e.g.) buttons - this returns the first couple of words from the name
    public var accessibilityLabel: String {
        recName
            .components(separatedBy: " ")
            .map({$0.trimmingCharacters(in: [" ", "#", ",", "-"])})
            .filter({!$0.isEmpty})
            .prefix(2)
            .joined(separator: " ")
    }
}
