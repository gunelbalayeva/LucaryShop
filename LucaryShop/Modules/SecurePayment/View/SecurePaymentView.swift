//
//  SecurePaymentView.swift
//  LucaryShop
//
//  Created by User on 28.06.25.
//

import Foundation
import UIKit
final class SecurePaymentView: UIView, UITextFieldDelegate {
    
    let addressLabel = UILabel().withStyle(text: "Çatdırılma ünvanı", size: 14)
    let addressField = CustomTextField().with(placeholder: "Ünvan:")
    
    let cardNumberLabel = UILabel().withStyle(text: "Kart nömrəsi", size: 14)
    let cardNumberField = CustomTextField().with(placeholder: "0000 0000 0000 0000")
    
    let expiryDateLabel = UILabel().withStyle(text: "Son istifadə tarixi", size: 14)
    let expiryDateField = CustomTextField().with(placeholder: "MM/YY")
    
    let cvvLabel = UILabel().withStyle(text: "CVV", size: 14)
    let cvvField = CustomTextField().with(placeholder: "CVV")
    
    let cardHolderLabel = UILabel().withStyle(text: "Kart sahibinin adı", size: 14)
    let cardHolderField = CustomTextField().with(placeholder: "Ad Soyad")
    
    private let confirmButton: CustomButton = {
        let button = CustomButton(style: .filled, height: 48, width: 200)
        button.setTitle("Ödənişi Təsdiqlə", for: .normal)
        return button
    }()
    
    var confirmButtonAction: (() -> Void)?
    
    private func createFieldGroup(label: UILabel, field: UITextField) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [label, field])
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }
    
    private lazy var expiryCvvStack: UIStackView = {
        let expiryStack = createFieldGroup(label: expiryDateLabel, field: expiryDateField)
        let cvvStack = createFieldGroup(label: cvvLabel, field: cvvField)
        let stack = UIStackView(arrangedSubviews: [expiryStack, cvvStack])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            createFieldGroup(label: addressLabel, field: addressField),
            createFieldGroup(label: cardNumberLabel, field: cardNumberField),
            expiryCvvStack,
            createFieldGroup(label: cardHolderLabel, field: cardHolderField),
            confirmButton
        ])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupUI()
        expiryDateField.delegate = self
        cardNumberField.delegate = self
        cvvField.delegate = self
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32)
            make.left.right.equalToSuperview().inset(24)
        }
    }
    
    @objc
    private func confirmTapped() {
        let fields: [UITextField] = [addressField, cardNumberField, expiryDateField, cvvField, cardHolderField]
        let areAllFieldsFilled = fields.allSatisfy { !( $0.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true ) }
        if areAllFieldsFilled {
            confirmButtonAction?()
        } else {
            showAlert(message: "Zəhmət olmasa bütün sahələri doldurun.")
        }
    }

    private func showAlert(message: String) {
        if let viewController = self.parentViewController {
            let alert = UIAlertController(title: "Xəta", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController.present(alert, animated: true)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == expiryDateField {
            let allowedCharacters = CharacterSet.decimalDigits
            if !CharacterSet(charactersIn: string).isSubset(of: allowedCharacters) && !string.isEmpty {
                return false
            }
            guard let currentText = textField.text else { return false }
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.count > 5 { return false }
            if newText.count == 2 && !newText.contains("/") && string != "" {
                textField.text = "\(newText)/"
                return false
            }
            return true
        }
        
        if textField == cardNumberField {
            let allowedCharacters = CharacterSet.decimalDigits
            if !CharacterSet(charactersIn: string).isSubset(of: allowedCharacters) && !string.isEmpty {
                return false
            }
            
            guard let currentText = textField.text else { return false }
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            let digitsOnly = newText.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
            if digitsOnly.count > 16 { return false }
            
            textField.text = formatCardNumber(digitsOnly)
            return false
        }
        
        if textField == cvvField {
            let allowedCharacters = CharacterSet.decimalDigits
            if !CharacterSet(charactersIn: string).isSubset(of: allowedCharacters) && !string.isEmpty {
                return false
            }
            
            guard let currentText = textField.text else { return false }
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return newText.count <= 3
        }
        
        return true
    }
    
    private func formatCardNumber(_ text: String) -> String {
        let digits = text.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
        var result = ""
        for (index, char) in digits.enumerated() {
            if index != 0 && index % 4 == 0 {
                result.append(" ")
            }
            result.append(char)
        }
        return result
    }
}
