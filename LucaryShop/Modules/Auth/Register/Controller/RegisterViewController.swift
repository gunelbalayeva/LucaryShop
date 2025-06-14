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
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layoutIfNeeded()
    }
    
    private func setupUI() {
        view.addSubview(registerView)
        registerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        registerView.onCreateAccountTapped = { [weak self] in
            self?.registerButtonTapped()
        }
    }
    
    init(viewModel: RegisterViewModel, coordinator: RegisterCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func registerButtonTapped() {
        let name = registerView.nameTextField.text ?? ""
        let surname = registerView.surnameTextField.text ?? ""
        let email = registerView.emailTextField.text ?? ""
        let password = registerView.passwordTextField.text ?? ""
        viewModel.register(name: name, surname: surname, email: email, password: password) {
            [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.showSuccessAndNavigate(with: name)
                case .failure(let error):
                    self?.showError(error.localizedDescription)
                }
            }
        }
    }
    
    private func showSuccessAndNavigate(with name: String) {
        let popup = SuccessPopupView(frame: view.bounds, userName: name)
        view.addSubview(popup)
        popup.dismiss(after: 3.0) { [weak self] in
            self?.coordinator.registerCompleted()
        }
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Xəta", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}
