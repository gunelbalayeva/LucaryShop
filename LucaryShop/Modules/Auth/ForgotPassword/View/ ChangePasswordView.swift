//
//   ChangePasswordView.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//
import UIKit
import Lottie
final class ChangePasswordView: UIView {
    var changePasswordTapped: (() -> Void)?
    private let headLabel = UILabel().withStyle(text: "Change Password", size: 24 )
    private let animationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "ChangePassword")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.play()
        return animation
    }()
    
    private let passwordLabel = UILabel().withStyle(text: "New password", size: 16)
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField().with(placeholder: "Enter new password")
        textField.layer.cornerRadius = 20
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
        backgroundColor = .verifyBg
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(180)
        }
        addSubview(headLabel)
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp.bottom).offset(16)
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
        changePasswordButton.addTarget(self, 
                                       action: #selector(changePasswordTappedAction),
                                       for: .touchUpInside)
    }

    
    @objc
    private func changePasswordTappedAction() {
        changePasswordTapped?()
    }
}
