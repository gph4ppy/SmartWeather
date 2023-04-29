//
//  WeatherViewController.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import UIKit

final class WeatherViewController: UIViewController {
    var weatherView: WeatherView!
    private var locationService: LocationServiceProtocol
    private var weatherManager: WeatherManagerProtocol

    init(
        locationService: LocationServiceProtocol = ApplicationServices.shared.locationService,
        weatherManager: WeatherManagerProtocol = ApplicationServices.shared.weatherManager
    ) {
        self.locationService = locationService
        self.weatherManager = weatherManager
        super.init(nibName: nil, bundle: nil)

        self.locationService.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        initializeWeatherView()
    }

    private func initializeWeatherView() {
        weatherView = WeatherView(
            symbol: weatherManager.symbol,
            temperature: weatherManager.temperature,
            condition: weatherManager.condition,
            city: locationService.city ?? "Unknown City"
        )
        view = weatherView
    }
}

extension WeatherViewController: LocationServiceDelegate {
    func didSetLocation() {
        Task {
            await weatherManager.getWeatherForLocation(locationService.manager.currentLocation)
            initializeWeatherView()
        }
    }
}
