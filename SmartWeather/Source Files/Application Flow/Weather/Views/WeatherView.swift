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
}

// MARK: - Setup Methods

private extension WeatherView {
    func setupView() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addCityLabel()
        addSymbolImageView()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            cityLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

            symbolView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 16),
            symbolView.widthAnchor.constraint(equalToConstant: 100),
            symbolView.heightAnchor.constraint(equalToConstant: 100),
            symbolView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

// MARK: - SubViews & Layers

private extension WeatherView {
    func addCityLabel() {
        let label = ComponentsFactory.createLabel(text: city, fontSize: 24, weight: .bold)
        cityLabel = label
        addSubview(cityLabel)
    }

    func addSymbolImageView() {
        let paletteColors: [UIColor] = [.white, .systemYellow, .systemBlue]
        let configuration = UIImage.SymbolConfiguration(paletteColors: paletteColors)
        let image = UIImage(
            systemName: symbol,
            withConfiguration: configuration
        )?.withRenderingMode(.alwaysTemplate)

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
