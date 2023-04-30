//
//  WeatherViewController+LocationServiceDelegate.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 30/04/2023.
//

import CoreLocation

extension WeatherViewController: LocationServiceDelegate {
    func locationService(_ locationService: LocationServiceProtocol, didSetLocation currentLocation: CLLocation) {
        weatherView.updateView(city: locationService.city)
        Task(priority: .background) { [weak self] in
            await self?.weatherManager.getWeatherForLocation(currentLocation)
        }
    }
}
