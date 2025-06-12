//
//  LoginViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class LoginViewController:UIViewController {
    private let splashView = LoginView()
    private let viewModel :LoginViewModel
    private let coordinator: LoginCoordinator
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

