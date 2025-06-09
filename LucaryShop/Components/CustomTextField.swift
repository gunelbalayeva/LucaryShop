//
//  CustomTextField.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class CustomTextField:UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupUI()
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    private func setupUI() {
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        backgroundColor = UIColor.systemBackground
        textColor = UIColor.label
        font = UIFont.systemFont(ofSize: 16)
        updateAppearance()
    }
    
    @objc
    private func editingChanged() {
        updateAppearance()
    }
    
    
    // MARK: - Appearance Update
    private func updateAppearance() {
        if !isEnabled {
            alpha = 0.5
            layer.borderColor = UIColor.systemGray4.cgColor
            return
        }
        
        if let text = text, !text.isEmpty {
            layer.borderColor = UIColor(named: "baseButton")?.cgColor
            alpha = 1.0
        } else {
            layer.borderColor = UIColor.systemGray4.cgColor
            alpha = 0.6
        }
    }
    
    
    // MARK: - UITextField Padding Overrides
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    
    // MARK: - Enabled State Override
    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
}
