//
//  WeatherManager.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import Foundation
import WeatherKit
import CoreLocation

protocol WeatherManagerDelegate: AnyObject {
    func weatherManager(_ weatherManager: WeatherManager, didSetWeather weather: Weather)
}

protocol WeatherManagerProtocol {
    var service: WeatherService { get }
    var delegate: WeatherManagerDelegate? { get set }
    var symbol: String { get }
    var temperature: String { get }
    var condition: String { get }
    func getWeatherForLocation(_ location: CLLocation) async
}

final class WeatherManager: WeatherManagerProtocol {

    // MARK: - Properties

    let service: WeatherService
    weak var delegate: WeatherManagerDelegate?
    private var weather: Weather?

    var symbol: String {
        weather?.currentWeather.symbolName ?? "location.slash.fill"
    }

    var temperature: String {
        let temperature = weather?.currentWeather.temperature.converted(to: .celsius)
        return temperature?.description ?? "?"
    }

    var condition: String {
        weather?.currentWeather.condition.description ?? "Unknown"
    }

    // MARK: - Initializers

    init(
        service: WeatherService = WeatherService(),
        currentWeather: Weather? = nil
    ) {
        self.service = service
        self.weather = currentWeather
    }

    // MARK: - Methods

    func getWeatherForLocation(_ location: CLLocation) async {
        do {
            let weather = try await service.weather(for: location)
            self.weather = weather
            delegate?.weatherManager(self, didSetWeather: weather)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
