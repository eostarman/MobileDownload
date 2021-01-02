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
}
