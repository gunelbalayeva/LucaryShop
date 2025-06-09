//
//  UILabel+Ext.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//
import UIKit

extension UILabel {
    func setStyle(fontSize: CGFloat, weight: UIFont.Weight = .regular, textColor: UIColor = .label) {
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textColor = textColor
    }
}
