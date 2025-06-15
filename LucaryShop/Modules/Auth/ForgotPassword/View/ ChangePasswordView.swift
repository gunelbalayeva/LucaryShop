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
        textField.isSecureTextEntry = true
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
        addSubviewSnp(passwordTextField, insets: .init(top: 60, left: 24, bottom: 0, right: 24))
        passwordTextField.setHeight(48)
        
        
    }
}
