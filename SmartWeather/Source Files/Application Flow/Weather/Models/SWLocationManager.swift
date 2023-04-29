//
//  SWLocationManager.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import CoreLocation

final class SWLocationManager: CLLocationManager {
    var latitude: Double?
    var longitude: Double?

    override init() {
        super.init()
    }

    var currentLocation: CLLocation {
        CLLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
    }

    func getPlaceMark() async -> (city: String?, country: String?) {
        guard let data = try? await currentLocation.fetchCityAndCountry() else { return (nil, nil) }
        return data
    }
}
