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
        view.backgroundColor = .red
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    init(viewModel: LoginViewModel, coordinator: LoginCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

