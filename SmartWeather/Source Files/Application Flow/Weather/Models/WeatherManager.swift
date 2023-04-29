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
    var symbol: String { get }
    var temperature: String { get }
    var condition: String { get }
    func getWeatherForLocation(_ location: CLLocation) async
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

    var symbol: String {
        currentWeather?.symbolName ?? "location.slash.fill"
    }

    var temperature: String {
        let temperature = currentWeather?.temperature.converted(to: .celsius)
        return temperature?.description ?? "?"
    }

    var condition: String {
        currentWeather?.condition.description ?? "Unknown"
    }

    func getWeatherForLocation(_ location: CLLocation) async {
        do {
            currentWeather = try await service.weather(for: location, including: .current)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
