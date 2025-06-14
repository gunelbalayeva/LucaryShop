//
//  UILabel+Ext.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//
import UIKit
extension UILabel {
    
    func setStyle(fontName: String? = nil, fontSize: CGFloat, weight: UIFont.Weight = .regular, textColor: UIColor = .label, alignment: NSTextAlignment = .natural, numberOfLines: Int = 1) {
        if let fontName = fontName, let customFont = UIFont(name: fontName, size: fontSize) {
            self.font = customFont
        } else {
            self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        }
        self.textColor = textColor
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
    
    func withStyle(text: String, size: CGFloat) -> UILabel {
            self.text = text
            self.textColor = .gray
            self.font = .systemFont(ofSize: size, weight: .medium)
            self.textAlignment = .left
            return self
        }
}
