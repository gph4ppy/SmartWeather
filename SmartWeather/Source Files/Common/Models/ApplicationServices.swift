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
    var locationService: LocationServiceProtocol

    init() {
        let locationManager = SWLocationManager()
        let locationService = LocationService(manager: locationManager)
        self.locationService = locationService

        let weatherManager = WeatherManager()
        self.weatherManager = weatherManager
    }
}
