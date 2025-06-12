//
//  RegisterViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class RegisterViewController :UIViewController {
    private let registerView = RegisterView()
    private let viewModel:RegisterViewModel
    private let coordinator: RegisterCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    init(viewModel: RegisterViewModel, coordinator: RegisterCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

