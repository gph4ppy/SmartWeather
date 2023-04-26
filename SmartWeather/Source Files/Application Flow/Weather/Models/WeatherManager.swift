//
//  WeatherManager.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import Foundation
import WeatherKit

protocol WeatherManagerProtocol {
    var service: WeatherService { get }
    var currentWeather: CurrentWeather? { get }
    func getWeatherForLocation() async
}

final class WeatherManager: WeatherManagerProtocol {
    let service: WeatherService
    var currentWeather: CurrentWeather?

    private var locationManager: LocationManagerProtocol

    init(
        service: WeatherService = WeatherService(),
        currentWeather: CurrentWeather? = nil,
        locationManager: LocationManagerProtocol = ApplicationServices.shared.locationManager
    ) {
        self.service = service
        self.currentWeather = currentWeather
        self.locationManager = locationManager
    }

    var symbol: String {
        currentWeather?.symbolName ?? "location.slash.fill"
    }

    var temperature: String {
        let temperature = currentWeather?.temperature.converted(to: .celsius)
        return temperature?.description ?? "Location Disabled"
    }

    var condition: String {
        currentWeather?.condition.description ?? "Unknown"
    }

    func getWeatherForLocation() async {
        do {
            let location = locationManager.currentLocation
            let weather = try await service.weather(for: location)
            currentWeather = weather.currentWeather
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
