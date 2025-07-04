//
//  UsersRegisterView.swift
//  LucaryShop
//
//  Created by User on 02.07.25.
//

import Foundation
import UIKit
import Lottie
final class UsersRegisterView:UIView{
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    var onCreateAccountTapped: (() -> Void)?
    
    private let headImageView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "Updates")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.play()
        return animation
    }()
    
    
    private let headLabel = UILabel().withStyle(text: "Update information", size: 24 )
    private let usernameLabel = UILabel().withStyle(text: "Name", size: 16)
    let nameTextField = CustomTextField().with(placeholder: "Enter your name")
    private let surnameLabel = UILabel().withStyle(text: "Surname", size: 16)
    let surnameTextField = CustomTextField().with(placeholder: "Enter your surname")
    
    private let emailLabel = UILabel().withStyle(text: "Email", size: 16)
    let emailTextField = CustomTextField().with(placeholder: "Enter email (e.g. you@example.com)")
    
    let createAccountButton: CustomButton = {
        let button = CustomButton(style: .filled)
        button.setTitle("Update", for: .normal)
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
                createAccountButton
            ],
            axis: .vertical,
            alignment: .fill,
            spacing: 16,
            insets: UIEdgeInsets(top: 0, left: 24, bottom: 45, right: 24)
        )
        
        [nameTextField, surnameTextField, emailTextField].forEach {
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
        guard let keyboardFrame = notification.userInfo?[
            UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
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
    
  
    @objc
    private func createAccountTapped() {
        onCreateAccountTapped?()
    }
    
    func configure(with user: User) {
        nameTextField.text = user.name
        surnameTextField.text = user.surname
        emailTextField.text = user.email
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
