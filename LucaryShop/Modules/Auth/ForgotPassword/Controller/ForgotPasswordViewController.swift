//
//  ForgotPasswordViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
final class ForgotPasswordViewController :UIViewController{
    
    private let forgotView = ForgotPasswordView()
    private let viewModel :ForgotPasswordViewModel
    private let coordinator: ForgotPasswordCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        view.addSubview(forgotView)
        forgotView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    init(viewModel: ForgotPasswordViewModel, coordinator: ForgotPasswordCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
