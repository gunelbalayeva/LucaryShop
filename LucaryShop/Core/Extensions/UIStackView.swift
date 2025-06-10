//
//  UIStackView.swift
//  LucaryShop
//
//  Created by User on 11.06.25.
//

import UIKit

extension UIStackView {
    func configure(axis: NSLayoutConstraint.Axis, alignment: Alignment, spacing: CGFloat) {
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
    }
}
