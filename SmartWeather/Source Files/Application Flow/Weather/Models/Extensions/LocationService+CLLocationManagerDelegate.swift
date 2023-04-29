//
//  LocationService+CLLocationManagerDelegate.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import CoreLocation

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse,
                .authorizedAlways:
            manager.requestLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }

    // MARK: - Required Methods

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.manager.stopUpdatingLocation()
        guard let newLocation = locations.first else { return }
        let latitude = newLocation.coordinate.latitude
        let longitude = newLocation.coordinate.longitude
        self.manager.latitude = latitude
        self.manager.longitude = longitude

        let group = DispatchGroup()
        group.enter()

        Task { [weak self] in
            guard let self else { return }
            let placeMark = await self.manager.getPlaceMark()
            self.city = placeMark.city
            group.leave()
        }

        group.notify(queue: .main) { [weak self] in
            self?.delegate?.didSetLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
}
