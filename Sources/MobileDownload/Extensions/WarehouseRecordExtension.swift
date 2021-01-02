//
//  WarehouseRecordExtension.swift
//  MobileBench (iOS)
//
//  Created by Michael Rutherford on 9/3/20.
//

import Foundation
import MapKit

extension WarehouseRecord {
    public var hasMapLocation: Bool {
        (shipLatitude != nil && shipLatitude != 0) || (shipLongitude != nil && shipLongitude != 0)
    }

    public var mapLocation: CLLocationCoordinate2D? {
        if !hasMapLocation {
            return nil
        }

        if let shipLatitude = shipLatitude, let shipLongitude = shipLongitude {
            return CLLocationCoordinate2D(latitude: shipLatitude, longitude: shipLongitude)
        }

        return nil
    }
}
