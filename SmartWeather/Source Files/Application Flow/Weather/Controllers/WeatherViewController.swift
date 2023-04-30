//
//  WeatherViewController.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import UIKit
import CoreLocation
import WeatherKit

final class WeatherViewController: UIViewController {

    // MARK: - Internal Properties

    var weatherView: WeatherView!

    // MARK: - Services

    private(set) var locationService: LocationServiceProtocol
    private(set) var weatherManager: WeatherManagerProtocol

    // MARK: - Views

    var loadingController: UIViewController {
        ComponentsFactory.createLoadingController(text: "Fetching weather...")
    }

    // MARK: - Initializers

    init(
        locationService: LocationServiceProtocol = ApplicationServices.shared.locationService,
        weatherManager: WeatherManagerProtocol = ApplicationServices.shared.weatherManager
    ) {
        self.locationService = locationService
        self.weatherManager = weatherManager
        super.init(nibName: nil, bundle: nil)
        self.locationService.delegate = self
        self.weatherManager.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Methods

    func showLoadingView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            present(self.loadingController, animated: true)
        }
    }

    func hideLoadingView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.dismiss(animated: true)
        }
    }

    private func setupView() {
        showLoadingView()
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
