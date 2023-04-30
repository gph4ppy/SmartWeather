//
//  ComponentsFactory.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 29/04/2023.
//

import UIKit

enum ComponentsFactory {
    enum Styling {
        // swiftlint: disable identifier_name
        static func addShadowToView(
            _ view: UIView,
            color: UIColor = .black,
            radius: CGFloat = 4.0,
            opacity: Float = 0.25,
            x: CGFloat = 0,
            y: CGFloat = 4
        ) {
            view.layer.shadowColor = color.cgColor
            view.layer.shadowRadius = radius
            view.layer.shadowOpacity = opacity
            view.layer.shadowOffset = CGSize(width: x, height: y)
            view.layer.masksToBounds = false
        }
        // swiftlint: enable identifier_name
    }

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
