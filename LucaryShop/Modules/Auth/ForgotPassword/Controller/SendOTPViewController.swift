//
//  SendOTPViewController.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit

final class SendOTPViewController :UIViewController{
    private let sendOtpView = SendOTPView()
    private let viewModel : SendOTPViewViewModel
    private let coordinator: ForgotPasswordCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(sendOtpView)
        sendOtpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    init(viewModel: SendOTPViewViewModel, coordinator: ForgotPasswordCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
