//
//  CustomButton.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//
import UIKit

enum ButtonStyle {
    case filled
    case outlined
    case plain
}

final class CustomButton: UIButton {
    private var buttonStyle: ButtonStyle
    private let buttonHeight: CGFloat
    private let buttonWidth: CGFloat
    private let spinner = UIActivityIndicatorView(style: .medium)
    private var originalTitle: String?
    
    init(style: ButtonStyle, height: CGFloat = 48, width: CGFloat = 200) {
        self.buttonStyle = style
        self.buttonHeight = height
        self.buttonWidth = width
        super.init(frame: .zero)
        setupUI()
        setupHapticFeedback()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        layer.cornerRadius = 12
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        applyStyle(buttonStyle)
        setupSpinner()
        setupConstraints()
    }
    
    private func applyStyle(_ style: ButtonStyle) {
        switch style {
        case .filled:
            backgroundColor = UIColor(named: "baseButton")
            setTitleColor(.white, for: .normal)
            layer.borderWidth = 1
            layer.borderColor = nil
        case .outlined:
            backgroundColor = .clear
            setTitleColor(UIColor(named: "baseButton"), for: .normal)
            layer.borderWidth = 2
            layer.borderColor = UIColor(named: "baseButton")?.cgColor
        case .plain:
            backgroundColor = .clear
            setTitleColor(UIColor(named: "baseButton"), for: .normal)
            layer.borderWidth = 0
            layer.borderColor = nil
        }
    }
    
    private func setupSpinner() {
        spinner.hidesWhenStopped = true
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.width.equalTo(buttonWidth)
        }
    }
    
    // MARK: - Haptic Feedback
    func setupHapticFeedback() {
        addTarget(self, action: #selector(triggerHaptic), for: .touchUpInside)
    }
    
    @objc private func triggerHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    // MARK: - Loading State
    func showLoading(_ isLoading: Bool) {
        if isLoading {
            originalTitle = title(for: .normal)
            setTitle("", for: .normal)
            spinner.startAnimating()
            isEnabled = false
        } else {
            setTitle(originalTitle, for: .normal)
            spinner.stopAnimating()
            isEnabled = true
        }
    }
    
    // MARK: - Enabled State Appearance
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
}
