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
    }
    
    init(viewModel: VerifyOTPViewModel, coordinator: ForgotPasswordCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
