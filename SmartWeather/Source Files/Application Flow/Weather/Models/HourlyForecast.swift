//
//  HourlyForecast.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 06/05/2023.
//

import Foundation

struct HourlyForecast {
    let hour: String
    let temperature: String
    let symbol: String

    init(hour: Date, temperature: String, symbol: String) {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        self.hour = formatter.string(from: hour)
        self.temperature = temperature
        self.symbol = symbol
    }
}
