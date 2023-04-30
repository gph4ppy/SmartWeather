//
//  UIImageExtension.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 30/04/2023.
//

import UIKit

extension UIImage {
    static func multicolorImage(
        systemName: String,
        palette: [UIColor] = [.white, .systemYellow, .systemBlue]
    ) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(paletteColors: palette)
        let image = UIImage(
            systemName: systemName,
            withConfiguration: configuration
        )?.withRenderingMode(.alwaysTemplate)
        return image
    }
}
