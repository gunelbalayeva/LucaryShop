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
        addTarget(self, action: #selector(editingBegan), for: .editingDidBegin)
        addTarget(self, action: #selector(editingEnded), for: .editingDidEnd)
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
    private func editingBegan() {
        animateBorderColor(to: UIColor(named: "baseButton")?.cgColor)
        alpha = 1.0
    }
    
    @objc
    private func editingEnded() {
        updateAppearance()
    }
    
    private func animateBorderColor(to color: CGColor?) {
        guard let color = color else { return }
        
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = color
        animation.duration = 0.25
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = color
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
    
    func with(placeholder: String) -> CustomTextField {
        self.placeholder = placeholder
        self.setHeight(42)
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor(named: "baseButton") ?? UIColor.gray
            ]
        )
        return self
    }
}
