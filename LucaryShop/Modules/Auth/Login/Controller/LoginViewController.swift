//
//  LoginViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
import SnapKit

final class LoginViewController:UIViewController {
    private let loginView = LoginView()
    private let viewModel :LoginViewModel
    private let coordinator: LoginCoordinator
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupActions()
    }
    override func loadView() {
        self.view = loginView
    }
    
    
    init(viewModel: LoginViewModel, coordinator: LoginCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupActions() {
        loginView.onLoginTapped = { [weak self] in
            guard let self = self else { return }
            let email = InputSanitizer.trimmed(self.loginView.emailTextField.text)
            let password = InputSanitizer.trimmed(self.loginView.passwordTextField.text)
            guard self.validateInput(email: email, password: password) else {
                return
            }
            self.viewModel.login(email: email, password: password) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.showSuccessAndNavigate(with: email)
                    case .failure(let error):
                        if let appError = error as? AppLoginError {
                            self.showError(appError.userMessage)
                        } else {
                            self.showError(error.localizedDescription)
                        }
                    }
                }
            }
        }
        loginView.onForgotPasswordTapped = { [weak self] in
            self?.viewModel.forgotPasswordTapped()
        }
    }
    
    
    private func showSuccessAndNavigate(with name: String) {
        coordinator.finish()
    }
    
}

