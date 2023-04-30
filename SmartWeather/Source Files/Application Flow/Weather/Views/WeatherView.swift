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

    // MARK: - Private Properties

    private var cityLabel: UILabel!
    private var symbolView: UIImageView!
    private var conditionLabel: UILabel!

    // MARK: - Initializers

    init(
        symbol: String,
        temperature: String,
        condition: String,
        city: String
    ) {
        self.symbol = symbol
        self.temperature = temperature
        self.condition = condition
        self.city = city
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
        city: String? = nil
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            if let symbol {
                symbolView.image = UIImage.multicolorImage(systemName: symbol)
            }

            if let city, let temperature {
                cityLabel.text = "\(city) (\(temperature))"
            }

            if let condition {
                conditionLabel.text = condition
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
            conditionLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

// MARK: - SubViews & Layers

private extension WeatherView {
    func addCityLabel() {
        let text = "\(city) (\(temperature))"
        let label = ComponentsFactory.createLabel(text: text, fontSize: 26, weight: .bold)
        cityLabel = label
        addSubview(cityLabel)
    }

    func addConditionLabel() {
        let label = ComponentsFactory.createLabel(text: condition, fontSize: 20, weight: .medium)
        conditionLabel = label
        addSubview(conditionLabel)
    }

    func addSymbolImageView() {
        let image = UIImage.multicolorImage(systemName: symbol)
        let imageView = ComponentsFactory.createImageView(image: image)
        symbolView = imageView
        addSubview(symbolView)
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
