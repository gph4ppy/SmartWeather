//
//  HourlyForecastView.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 06/05/2023.
//

import UIKit

class HourlyForecastView: UIScrollView {
    let forecast: [HourlyForecast]
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()

    init(forecast: [HourlyForecast]) {
        self.forecast = forecast
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateView(for forecast: [HourlyForecast]) {
        stackView.removeAllArrangedSubviews()
        addHourForecastViews(data: forecast)
    }

    private func addHourForecastViews(data: [HourlyForecast]) {
        let limiter = 12
        guard data.count >= limiter else { return }
        for forecast in data[0...limiter] {
            let forecastView = UIStackView()
            forecastView.axis = .vertical
            forecastView.spacing = 8
            forecastView.alignment = .center

            let weatherImage = UIImage.multicolorImage(systemName: forecast.symbol)
            let weatherImageView = UIImageView(image: weatherImage)
            weatherImageView.contentMode = .scaleAspectFit

            forecastView.addArrangedSubview(weatherImageView)

            let temperatureLabel = ComponentsFactory.createLabel(
                text: forecast.temperature,
                fontSize: 14,
                weight: .regular
            )
            forecastView.addArrangedSubview(temperatureLabel)

            let timeLabel = ComponentsFactory.createLabel(text: forecast.hour, fontSize: 12, weight: .bold)
            forecastView.addArrangedSubview(timeLabel)

            stackView.addArrangedSubview(forecastView)
        }
    }
}

// MARK: - Setup Methods

private extension HourlyForecastView {
    private func setupView() {
        setupScrollViewStyling()
        addSubviews()
        setupConstraints()
    }

    private func setupScrollViewStyling() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .gray
        layer.compositingFilter = "overlayBlendMode"
        layer.cornerRadius = 18
        showsHorizontalScrollIndicator = false
    }

    private func addSubviews() {
        addSubview(stackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
