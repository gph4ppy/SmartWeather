//
//  WeatherViewController+WeatherManagerDelegate.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 30/04/2023.
//

import WeatherKit

extension WeatherViewController: WeatherManagerDelegate {
    func weatherManager(_ weatherManager: WeatherManager, didFetchWeather weather: Weather) {
        hideLoadingView()
        weatherView.updateView(
            symbol: weatherManager.symbol,
            temperature: weatherManager.temperature,
            condition: weatherManager.condition,
            city: locationService.city,
            hourlyForecast: weatherManager.hourlyForecast
        )
    }
}
