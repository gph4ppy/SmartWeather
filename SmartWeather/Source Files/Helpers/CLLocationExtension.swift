//
//  CLLocationExtension.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import CoreLocation

extension CLLocation {
    func fetchCityAndCountry() async throws -> (city: String?, country: String?) {
        let place = try await CLGeocoder().reverseGeocodeLocation(self)
        return (place.first?.locality, place.first?.country)
    }
}
