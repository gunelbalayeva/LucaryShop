//
//  ChangePasswordViewController  .swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit
import Combine
final class ChangePasswordViewController:UIViewController{
    private let changePasswordView = ChangePasswordView()
    private let viewModel :ChangePasswordViewModel
    private let coordinator: ForgotPasswordCoordinator
    private var cancellables = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupActions()
        setupUI()
        if let token = KeychainManager.shared.getToken() {
            print(token)
        } else {
            print("Token tapılmadı")
        }
    }
    
    private func setupUI() {
        view.addSubview(changePasswordView)
        changePasswordView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    init(viewModel: ChangePasswordViewModel,
         coordinator: ForgotPasswordCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindings() {
        Publishers.CombineLatest(
            viewModel.$password,
            viewModel.$hasStartedTyping
        )
        .dropFirst()
        .receive(on: RunLoop.main)
        .sink { [weak self] password, hasStartedTyping in
            guard let self = self else { return }
            let isPasswordValid = InputSanitizer.isValidPassword(password)
            if hasStartedTyping {
                self.changePasswordView.passwordTextField.layer.borderWidth = 1
                self.changePasswordView.passwordTextField.layer.borderColor = isPasswordValid ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
            } else {
                self.changePasswordView.passwordTextField.layer.borderWidth = 0
            }

            self.changePasswordView.changePasswordButton.isEnabled = isPasswordValid
            self.changePasswordView.changePasswordButton.alpha = isPasswordValid ? 1.0 : 0.5
        }
        .store(in: &cancellables)
    }
    
    private func setupActions() {
        changePasswordView.passwordTextField.addTarget(self, action: #selector(passwordTextChanged(_:)), for: .editingChanged)
        changePasswordView.passwordTextField.addTarget(self, action: #selector(passwordEditingDidBegin(_:)), for: .editingDidBegin)
        changePasswordView.passwordTextField.addTarget(self, action: #selector(passwordEditingDidEnd(_:)), for: .editingDidEnd)
        
        changePasswordView.changePasswordButton.addTarget(self, action: #selector(changePasswordTapped), for: .touchUpInside)
    }
    
  
    @objc
    private func passwordTextChanged(_ sender: UITextField) {
        viewModel.password = InputSanitizer.trimmed(sender.text)
    }
    
    @objc
    private func passwordEditingDidBegin(_ sender: UITextField) {
        viewModel.hasStartedTyping = true
    }
    
    @objc
    private func passwordEditingDidEnd(_ sender: UITextField) {
        let text = sender.text
           let isValid = InputSanitizer.isValidPassword(text)
           if !isValid {
               let alert = UIAlertController(
                   title: "Weak password",
                   message: "The password must be at least 6 characters long and contain both letters and numbers.",
                   preferredStyle: .alert
               )
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               present(alert, animated: true)
           }
    }
    
    @objc
    private func changePasswordTapped() {
        viewModel.changePassword { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.viewModel.didSuccessfullyChangePassword()
                case .failure(let error):
                    self?.showError(error)
                }
            }
        }
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(
            title: "Xəta",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
