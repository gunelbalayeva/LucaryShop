//
//  LoginView.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit

final class LoginView :UIView{
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let passwordContainer = UIView()
    var onLoginTapped: (() -> Void)?
    var onForgotPasswordTapped: (() -> Void)?
    
    private let headImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.setHeight(150)
        image.clipsToBounds = true
        image.image = UIImage(named: "logo")
        return image
    }()
    
    private let headLabel = UILabel().withStyle(text: "Login Account", size: 24)
    private let emailLabel = UILabel().withStyle(text: "Email", size: 16)
    let emailTextField = CustomTextField().with(placeholder: "Enter email (e.g. you@example.com)")
    private let passwordLabel = UILabel().withStyle(text: "Password", size: 16)
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField().with(placeholder: "Enter your password")
        textField.isSecureTextEntry = true
        textField.setHeight(44)
        return textField
    }()
    
    let forgotPasswordButton: CustomButton = {
        let button = CustomButton(style: .plain)
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    let loginButton: CustomButton = {
        let button = CustomButton(style: .filled)
        button.setTitle("Sign In", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubviews(views: scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToSuperviewEdges()
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        contentView.addSubview(passwordContainer)
        passwordContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(44 + 20 + 30)
        }
        passwordContainer.addSubviews(views: passwordTextField, forgotPasswordButton)
        passwordTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(30)
            make.width.lessThanOrEqualTo(150)
        }
        contentView.addStackView(
            subviews: [
                headImageView,
                headLabel,
                emailLabel,
                emailTextField,
                passwordLabel,
                passwordContainer,
                loginButton
            ],
            axis: .vertical,
            alignment: .fill,
            spacing: 16,
            insets: UIEdgeInsets(top: 32, left: 24, bottom: 32, right: 24)
        )
        [emailTextField, passwordTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidTap(_:)), for: .editingDidBegin)
        }
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        loginButton.setupHapticFeedback()
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
    }
    
    @objc
    private func loginTapped() {
        onLoginTapped?()
    }
    
    @objc
    private func forgotPasswordTapped() {
        onForgotPasswordTapped?()
    }
    
    @objc
    private func textFieldDidTap(_ textField: UITextField) {
        DispatchQueue.main.async {
            textField.becomeFirstResponder()
            let rect = textField.convert(textField.bounds, to: self.scrollView)
            self.scrollView.scrollRectToVisible(rect, animated: true)
        }
    }
}


