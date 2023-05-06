//
//  UIStackViewExtension.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 06/05/2023.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        removedSubviews.forEach { $0.removeFromSuperview() }
    }
}
