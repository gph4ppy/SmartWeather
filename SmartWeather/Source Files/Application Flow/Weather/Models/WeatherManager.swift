//
//  WeatherManager.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import Foundation
import WeatherKit
import CoreLocation

protocol WeatherManagerProtocol {
    var service: WeatherService { get }
    var currentWeather: CurrentWeather? { get }
    func getWeatherForLocation(location: CLLocation) async
}

final class WeatherManager: WeatherManagerProtocol {
    let service: WeatherService
    var currentWeather: CurrentWeather?

    init(
        service: WeatherService = WeatherService(),
        currentWeather: CurrentWeather? = nil
    ) {
        self.service = service
        self.currentWeather = currentWeather
    }

    func getWeatherForLocation(location: CLLocation) async {
        do {
            let weather = try await service.weather(for: location)
            currentWeather = weather.currentWeather
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
