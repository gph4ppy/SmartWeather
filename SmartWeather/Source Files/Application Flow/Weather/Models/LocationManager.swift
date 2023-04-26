//
//  LocationManager.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import CoreLocation

protocol LocationManagerProtocol {
    var service: CLLocationManager { get }
    var latitude: Double { get }
    var longitude: Double { get }
    var currentLocation: CLLocation { get }
}

extension LocationManagerProtocol {
    var currentLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}

final class LocationManager: NSObject, LocationManagerProtocol {
    let service: CLLocationManager

    init(service: CLLocationManager = CLLocationManager()) {
        self.service = service
        super.init()
        service.delegate = self
    }

    var latitude: Double {
        service.location?.coordinate.latitude ?? 0
    }

    var longitude: Double {
        service.location?.coordinate.longitude ?? 0
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse,
             .authorizedAlways:
            service.requestLocation()
        case .notDetermined:
            service.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}
