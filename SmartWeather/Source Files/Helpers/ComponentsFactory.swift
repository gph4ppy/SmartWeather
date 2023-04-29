//
//  ComponentsFactory.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 29/04/2023.
//

import UIKit

enum ComponentsFactory {
    static func createLabel(text: String, fontSize: CGFloat, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        return label
    }

    static func createImageView(image: UIImage?) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
