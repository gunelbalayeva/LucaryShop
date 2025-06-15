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
                self.showError("Email daxil edilməlidir.")
                return
            }
            guard isValidEmail(email) else {
                self.showError("Düzgün formatda email daxil edin.")
                return
            }
            self.viewModel.sendOTP(email: email) { success in
                DispatchQueue.main.async {
                    if success {
                        self.coordinator.navigate(to: .verifyOTP)
                    } else {
                        self.showError("OTP göndərilə bilmədi.")
                    }
                }
            }
        }

    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Xəta", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}
