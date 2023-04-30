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

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.manager.stopUpdatingLocation()
        guard let newLocation = locations.first else { return }
        let latitude = newLocation.coordinate.latitude
        let longitude = newLocation.coordinate.longitude
        let location = CLLocation(latitude: latitude, longitude: longitude)

        let group = DispatchGroup()
        group.enter()

        Task { [weak self] in
            guard let self else { return }
            let placeMark = await self.manager.getPlaceMark(of: location)
            self.city = placeMark.city
            group.leave()
        }

        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            self.delegate?.locationService(self, didSetLocation: location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
}
