//
//  SWLocationManager.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import CoreLocation

final class SWLocationManager: CLLocationManager {
    override init() {
        super.init()
    }

    var latitude: Double {
        location?.coordinate.latitude ?? 0
    }

    var longitude: Double {
        location?.coordinate.longitude ?? 0
    }

    var currentLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }

    func getPlaceMark() async -> (city: String?, country: String?) {
        guard let data = try? await currentLocation.fetchCityAndCountry() else { return (nil, nil) }
        return data
    }
}
