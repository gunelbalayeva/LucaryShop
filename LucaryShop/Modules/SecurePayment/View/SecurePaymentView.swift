//
//  SecurePaymentView.swift
//  LucaryShop
//
//  Created by User on 28.06.25.
//

import Foundation
import UIKit
final class SecurePaymentView: UIView {
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Çatdırılma ünvanı"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "İnşaatçılar prospekti, Bakı"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    private let paymentOptionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Ödəmə seçimləri"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let cardPaymentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kartla ödəniş", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let cashPaymentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Nağd ödəniş (qapıda)", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let googlePayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Google Pay ilə ödə", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let cardDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Kart məlumatları"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let cardNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Kart nömrəsi"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let expirationDateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Son istifadə tarixi (AA/YY)"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()
    
    private let cvvTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "CVV"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let confirmCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Təsdiq et və bitir", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(addressLabel)
        addSubview(addressTextField)
        addSubview(paymentOptionsLabel)
        addSubview(cardPaymentButton)
        addSubview(cashPaymentButton)
        addSubview(googlePayButton)
        addSubview(cardDetailsLabel)
        addSubview(cardNumberTextField)
        addSubview(expirationDateTextField)
        addSubview(cvvTextField)
        addSubview(confirmCartButton)
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(16)
        }
        
        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        paymentOptionsLabel.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        cardPaymentButton.snp.makeConstraints { make in
            make.top.equalTo(paymentOptionsLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        cashPaymentButton.snp.makeConstraints { make in
            make.top.equalTo(cardPaymentButton.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        googlePayButton.snp.makeConstraints { make in
            make.top.equalTo(cashPaymentButton.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        cardDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(googlePayButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        cardNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(cardDetailsLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        expirationDateTextField.snp.makeConstraints { make in
            make.top.equalTo(cardNumberTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.45)
            make.height.equalTo(40)
        }
        
        cvvTextField.snp.makeConstraints { make in
            make.top.equalTo(cardNumberTextField.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalToSuperview().multipliedBy(0.45)
            make.height.equalTo(40)
        }
        
        confirmCartButton.snp.makeConstraints { make in
            make.top.equalTo(expirationDateTextField.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(48)
        }
    }
}
