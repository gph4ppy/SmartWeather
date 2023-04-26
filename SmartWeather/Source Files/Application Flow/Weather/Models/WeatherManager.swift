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

    private var locationService: LocationServiceProtocol

    init(
        service: WeatherService = WeatherService(),
        currentWeather: CurrentWeather? = nil,
        locationService: LocationServiceProtocol = ApplicationServices.shared.locationService
    ) {
        self.service = service
        self.currentWeather = currentWeather
        self.locationService = locationService
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

    var city: String {
        locationService.city ?? "Unknown City"
    }

    func getWeatherForLocation() async {
        do {
            let location = locationService.manager.currentLocation
            let weather = try await service.weather(for: location)
            currentWeather = weather.currentWeather
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
