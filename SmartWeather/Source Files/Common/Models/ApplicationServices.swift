//
//  ApplicationServices.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import Foundation

final class ApplicationServices {
    static let shared = ApplicationServices()

    var weatherManager: WeatherManagerProtocol
    var locationManager: LocationManagerProtocol

    init(
        weatherManager: WeatherManagerProtocol = WeatherManager(),
        locationManager: LocationManagerProtocol = LocationManager()
    ) {
        self.weatherManager = weatherManager
        self.locationManager = locationManager
    }
}
