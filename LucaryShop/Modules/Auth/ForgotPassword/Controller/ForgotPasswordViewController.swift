//
//  ForgotPasswordViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
final class ForgotPasswordViewController :UIViewController{
    private let forgotView = SendOTPView()
    private let viewModel :ForgotPasswordViewModel
    private let coordinator: ForgotPasswordCoordinator
    private let authService: AuthService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Forgot Password"
        setupUI()
    }
    
    init(viewModel: ForgotPasswordViewModel, coordinator: ForgotPasswordCoordinator, authService: AuthService) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.addSubview(forgotView)
        forgotView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        forgotView.onSendCodeTapped = { [weak self] in
            guard let self = self else { return }
            let email = self.forgotView.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            guard !email.isEmpty else {
                self.showError("Email must be entered.")
                return
            }
            guard isValidEmail(email) else {
                self.showError("Please enter an email in the correct format")
                return
            }
            self.viewModel.sendOTP(email: email) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let verificationId):
                        self.coordinator.navigateToVerifyOTP(with: verificationId)
                    case .failure(_):
                        self.showError("OTP could not be sent.")
                    }
                }
            }
        }
    }
}
