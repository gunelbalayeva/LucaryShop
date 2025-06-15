//
//  SendOTPView.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit

final class SendOTPView :UIView{
    
    var onSendCodeTapped: (() -> Void)?
    private let headImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "logo")
        return image
    }()
    private let headLabel = UILabel().withStyle(text: "Send OTP Code", size: 24)
    
    private let emailLabel = UILabel().withStyle(text: "Email", size: 16)
    
    let emailTextField: CustomTextField = {
        let textField = CustomTextField().with(placeholder: "Enter email (e.g. you@example.com)")
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 20
        textField.textContentType = .none
        textField.setHeight(44)
        return textField
    }()
    
    let getPasswordButton: CustomButton = {
        let button = CustomButton(style: .filled)
        button.setTitle("Send Code", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubviews(views: headImageView, headLabel, emailLabel, emailTextField, getPasswordButton)
        setupConstraints()
        getPasswordButton.addTarget(self, action: #selector(sendCodeTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
        }
        headImageView.setSize(width: 150, height: 150)
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(headImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
        
        getPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
    }
    
    
    @objc
    private func sendCodeTapped() {
        onSendCodeTapped?()
    }
}
