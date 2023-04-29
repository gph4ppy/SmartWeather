//
//  WeatherViewController.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import UIKit

final class WeatherViewController: UIViewController {

    // MARK: - Internal Properties

    var weatherView: WeatherView!

    // MARK: - Services

    private var locationService: LocationServiceProtocol
    private var weatherManager: WeatherManagerProtocol

    // MARK: - Initializers

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

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

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

// MARK: - WeatherViewController+LocationServiceDelegate

extension WeatherViewController: LocationServiceDelegate {
    func didSetLocation() {
        let group = DispatchGroup()
        group.enter()

        Task(priority: .background) {
            let currentLocation = locationService.manager.currentLocation
            await weatherManager.getWeatherForLocation(currentLocation)
            group.leave()
        }

        group.notify(queue: .main) { [weak self] in
            self?.initializeWeatherView()
        }
    }
}
