//
//  WeatherViewController.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import UIKit

/// A view controller that specializes in managing a weather view.
final class WeatherViewController: UIViewController {

    // MARK: - Internal Properties

    /// A view presenting the weather.
    var weatherView: WeatherView!

    // MARK: - Services

    /// A service used for managing user's location.
    private(set) var locationService: LocationServiceProtocol
    /// A service used for managing the weather.
    private(set) var weatherManager: WeatherManagerProtocol

    // MARK: - Views

    /// A view controller presented when the weather is being fetched.
    var loadingController: UIViewController {
        ComponentsFactory.createLoadingController(text: "Fetching weather...")
    }

    // MARK: - Initializers

    /// Creates a view controller which presents the weather.
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

    // MARK: - Internal Methods

    /// This method presents the loading view controller.
    func showLoadingView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            present(self.loadingController, animated: true)
        }
    }

    /// This method dismisses the loading view controller.
    func hideLoadingView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.dismiss(animated: true)
        }
    }

    // MARK: - Private Methods

    /// This method setups the view.
    private func setupView() {
        showLoadingView()
        initializeWeatherView()
    }

    /// This method initializes the WeatherView and assigns it to the view controller's view.
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
