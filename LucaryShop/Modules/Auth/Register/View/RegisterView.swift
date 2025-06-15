//
//  RegisterView.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit

final class RegisterView:UIView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    var onCreateAccountTapped: (() -> Void)?
    
    private let headImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.setHeight(150)
        image.clipsToBounds = true
        image.image = UIImage(named: "logo")
        return image
    }()
    
    private let headLabel = UILabel().withStyle(text: "Create Account", size: 24 )
    private let usernameLabel = UILabel().withStyle(text: "Name", size: 16)
    let nameTextField = CustomTextField().with(placeholder: "Enter your name")
    private let surnameLabel = UILabel().withStyle(text: "Surname", size: 16)
    let surnameTextField = CustomTextField().with(placeholder: "Enter your surname")
    private let emailLabel = UILabel().withStyle(text: "Email", size: 16)
    let emailTextField = CustomTextField().with(placeholder: "Enter your e-mail")
    private let passwordLabel = UILabel().withStyle(text: "Password", size: 16)
    
    let passwordTextField: CustomTextField = {
        let textField = CustomTextField().with(placeholder: "Enter your name")
        textField.placeholder = "Create your password"
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 20
        textField.textContentType = .none
        textField.setHeight(44)
        return textField
    }()
    
    
    let createAccountButton: CustomButton = {
        let button = CustomButton(style: .filled)
        button.setTitle("Create Account", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupKeyboardObservers()
        addTapGestureToHideKeyboard()
        createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.layoutIfNeeded()
        contentView.layoutIfNeeded()
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
        contentView.addStackView(
            subviews: [
                headImageView,
                headLabel,
                usernameLabel,
                nameTextField,
                surnameLabel,
                surnameTextField,
                emailLabel,
                emailTextField,
                passwordLabel,
                passwordTextField,
                createAccountButton
            ],
            axis: .vertical,
            alignment: .fill,
            spacing: 16,
            insets: UIEdgeInsets(top: 32, left: 24, bottom: 32, right: 24)
        )
        
        [nameTextField, surnameTextField, emailTextField, passwordTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidTap(_:)), for: .editingDidBegin)
        }
    }
    
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func addTapGestureToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    
    // MARK: - Keyboard Handlers
    @objc
    private func dismissKeyboard() {
        endEditing(true)
    }
    
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let bottomInset = keyboardFrame.height - safeAreaInsets.bottom + 16
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
        UIView.animate(withDuration: 0.3) {
            self.headImageView.alpha = 0
            self.layoutIfNeeded()
        }
    }
    
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
        UIView.animate(withDuration: 0.3) {
            self.headImageView.alpha = 1
            self.headLabel.alpha = 1
            self.layoutIfNeeded()
        }
    }
    
    
    @objc
    private func textFieldDidTap(_ textField: UITextField) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            textField.becomeFirstResponder()
            let rect = textField.convert(textField.bounds, to: self.scrollView)
            self.scrollView.scrollRectToVisible(rect, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func createAccountTapped() {
        onCreateAccountTapped?()
    }
}
