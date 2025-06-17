//
//   ChangePasswordView.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit

final class ChangePasswordView: UIView {
    
    var changePasswordTapped: (() -> Void)?
    private let headLabel = UILabel().withStyle(text: "Change Password", size: 24 )
    
    private let headImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "logo")
        return image
    }()
    
    private let emailLabel = UILabel().withStyle(text: "Email", size: 16)
    let emailTextField = CustomTextField().with(placeholder: "Enter email (e.g. you@example.com)")
    
    private let passwordLabel = UILabel().withStyle(text: "Password", size: 16)
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField().with(placeholder: "Change your password")
        textField.layer.cornerRadius = 20
        textField.textContentType = .none
        textField.setHeight(44)
        return textField
    }()
    
    
    let changePasswordButton: CustomButton = {
        let button = CustomButton(style: .filled)
        button.setTitle("Change Password", for: .normal)
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
        addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
        }

        addSubview(headLabel)
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(headImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
        }

        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }

        addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
        }

        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }

        addSubview(changePasswordButton)
        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }

        changePasswordButton.addTarget(self, action: #selector(changePasswordTappedAction), for: .touchUpInside)
    }

    @objc 
    private func changePasswordTappedAction() {
        changePasswordTapped?()
    }

}
