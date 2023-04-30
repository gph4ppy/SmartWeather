//
//  LocationServiceDelegate.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 30/04/2023.
//

import CoreLocation

/// The interface for methods related to user's location.
protocol LocationServiceDelegate: AnyObject {
    /// Tells a delegate that the location has been set.
    func locationService(_ locationService: LocationServiceProtocol, didSetLocation currentLocation: CLLocation)
}
