//
//  VerifyOTPViewController.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import Foundation
import UIKit

final class VerifyOTPViewController :UIViewController{
    private let vertfyOtpView = VerifyOTPView()
    private let viewModel :VerifyOTPViewModel
    private let coordinator: ForgotPasswordCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupUI()
        vertfyOtpView.verifyOTPCodeTapped = { [weak self] in
            self?.submitOTP()
        }
    }
    
    init(viewModel: VerifyOTPViewModel, coordinator: ForgotPasswordCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.addSubview(vertfyOtpView)
        vertfyOtpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    private func submitOTP() {
        let rawCode = vertfyOtpView.sixTextField.text
        let code = InputSanitizer.trimmed(rawCode)
        guard code.count == 6 else {
            showErrorAnimation(message: "Please enter the 6-digit OTP code.")
            return
        }
        
        let verificationId = viewModel.verificationId
        viewModel.verifyOTP(code: code, verificationId: verificationId) { [weak self] success in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                if success {
                    print("OTP Verified")
                    self.showSuccessAndNavigate(with: "Dear user,")
                } else {
                    print("OTP Failed")
                    self.showErrorAnimation(message: "OTP code entered incorrectly")
                }
            }
        }
    }
    
    private func showErrorAnimation(message: String) {
        let popup = ErrorPopupView(frame: view.bounds, message: message)
        view.addSubview(popup)
        popup.dismiss(after: 3.0)
    }
    
    private func showSuccessAndNavigate(with name: String) {
        let popup = VerifySuccessPopupView(frame: view.bounds, userName: name)
        view.addSubview(popup)
        popup.dismiss(after: 3.0) { [weak self] in
            self?.coordinator.navigate(to: .changePassword)
        }
    }
}
