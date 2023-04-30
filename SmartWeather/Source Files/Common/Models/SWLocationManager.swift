//
//  SWLocationManager.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import CoreLocation

final class SWLocationManager: CLLocationManager {
    func getPlaceMark(of location: CLLocation) async -> (city: String?, country: String?) {
        guard let data = try? await location.fetchCityAndCountry() else { return (nil, nil) }
        return data
    }
}
