//
//  WeatherManagerDelegate.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 30/04/2023.
//

import WeatherKit

/// The interface for methods related to the weather.
protocol WeatherManagerDelegate: AnyObject {
    /// Tells a delegate that a weather has been fetched.
    func weatherManager(_ weatherManager: WeatherManager, didFetchWeather weather: Weather)
}
