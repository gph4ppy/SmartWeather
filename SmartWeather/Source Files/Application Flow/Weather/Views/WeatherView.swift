//
//  WeatherView.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 27/04/2023.
//

import UIKit

final class WeatherView: UIView {
    let symbol: String
    let temperature: String
    let condition: String
    let city: String

    private var cityLabel: UILabel!
    private var symbolView: UIImageView!

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
        backgroundColor = .red
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = city
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        cityLabel = label
        addSubview(cityLabel)

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: symbol)
        imageView.contentMode = .scaleAspectFit
        symbolView = imageView
        addSubview(symbolView)
    }

    private func setupConstraints() {
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
