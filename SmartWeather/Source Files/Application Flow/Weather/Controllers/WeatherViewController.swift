//
//  WeatherViewController.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import UIKit

final class WeatherViewController: UIViewController {
    private var locationService: LocationServiceProtocol
    private var weatherManager: WeatherManagerProtocol

    init(
        locationService: LocationServiceProtocol = ApplicationServices.shared.locationService,
        weatherManager: WeatherManagerProtocol = ApplicationServices.shared.weatherManager
    ) {
        self.locationService = locationService
        self.weatherManager = weatherManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
