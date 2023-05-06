//
//  WeatherView.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 27/04/2023.
//

import UIKit

final class WeatherView: UIView {

    // MARK: - Internal properties

    let symbol: String
    let temperature: String
    let condition: String
    let city: String
    let hourForecast: [HourlyForecast]

    // MARK: - Private Properties

    private var cityLabel: UILabel!
    private var symbolView: UIImageView!
    private var conditionLabel: UILabel!
    private var hourlyForecastView: HourlyForecastView!

    // MARK: - Initializers

    init(
        symbol: String,
        temperature: String,
        condition: String,
        city: String,
        hourlyForecast: [HourlyForecast]
    ) {
        self.symbol = symbol
        self.temperature = temperature
        self.condition = condition
        self.city = city
        self.hourForecast = hourlyForecast
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func didMoveToWindow() {
        setGradientBackground()
    }

    // MARK: - Methods

    func updateView(
        symbol: String? = nil,
        temperature: String? = nil,
        condition: String? = nil,
        city: String? = nil,
        hourlyForecast: [HourlyForecast] = []
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            if let symbol {
                symbolView.image = UIImage.multicolorImage(systemName: symbol)
            }

            if let city {
                cityLabel.text = city
            }

            if let temperature, let condition {
                conditionLabel.text = temperature + " | " + condition
            }

            if !hourlyForecast.isEmpty {
                hourlyForecastView.updateView(for: hourlyForecast)
            }
        }
    }
}

// MARK: - Setup Methods

private extension WeatherView {
    func setupView() {
        addSubviews()
        setupConstraints()
        setStyling()
    }

    func addSubviews() {
        addCityLabel()
        addSymbolImageView()
        addConditionLabel()
        addDailyTemperatureScrollView()
    }

    func setStyling() {
        ComponentsFactory.Styling.addShadowToView(cityLabel)
        ComponentsFactory.Styling.addShadowToView(symbolView)
        ComponentsFactory.Styling.addShadowToView(conditionLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            cityLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

            symbolView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            symbolView.widthAnchor.constraint(equalToConstant: 100),
            symbolView.heightAnchor.constraint(equalToConstant: 100),
            symbolView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

            conditionLabel.topAnchor.constraint(equalTo: symbolView.bottomAnchor, constant: 8),
            conditionLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

            hourlyForecastView.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 16),
            hourlyForecastView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hourlyForecastView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            hourlyForecastView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

// MARK: - SubViews & Layers

private extension WeatherView {
    func addCityLabel() {
        let label = ComponentsFactory.createLabel(text: city, fontSize: 26, weight: .bold)
        cityLabel = label
        addSubview(cityLabel)
    }

    func addConditionLabel() {
        let text = temperature + " | " + condition
        let label = ComponentsFactory.createLabel(text: text, fontSize: 20, weight: .medium)
        conditionLabel = label
        addSubview(conditionLabel)
    }

    func addSymbolImageView() {
        let image = UIImage.multicolorImage(systemName: symbol)
        let imageView = ComponentsFactory.createImageView(image: image)
        symbolView = imageView
        addSubview(symbolView)
    }

    func addDailyTemperatureScrollView() {
        let forecastView = HourlyForecastView(forecast: hourForecast)
        hourlyForecastView = forecastView
        addSubview(hourlyForecastView)
    }

    func setGradientBackground() {
        let bottomColor = UIColor(red: 0.504, green: 0.732, blue: 1, alpha: 1)
        let topColor =  UIColor(red: 0, green: 0.04, blue: 1, alpha: 0)
        let gradient = CAGradientLayer()
        gradient.colors = [bottomColor.cgColor, topColor.cgColor]
        gradient.locations = [0, 1]
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
    }
}
