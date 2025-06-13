//
//   ChangePasswordView.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit

final class ChangePasswordView: UIView {
    
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Yeni şifrəni daxil edin"
        return textField
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Şifrə güclü olmalıdır"
        label.setStyle(fontSize: 14, textColor: .gray, alignment: .center)
        return label
    }()
    
    let changePasswordButton: CustomButton = {
        let button = CustomButton(style: .filled)
        button.setTitle("Şifrəni dəyiş", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubviewSnp(passwordTextField, insets: .init(top: 60, left: 24, bottom: 0, right: 24))
        passwordTextField.setHeight(48)
        
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        addSubview(changePasswordButton)
        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }
    }
}
