//
//  UIImageExtension.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 30/04/2023.
//

import UIKit

extension UIImage {
    /// This method creates a multicolor system symbol image object.
    /// - Parameters:
    ///   - systemName: The name of system symbol image.
    ///   - palette: An array of colors used for creating a color configuration with color scheme.
    /// - Returns: A multicolor system symbol image object.
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
