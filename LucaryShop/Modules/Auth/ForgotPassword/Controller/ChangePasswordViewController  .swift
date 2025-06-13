//
//  ChangePasswordViewController  .swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit
import Combine
final class ChangePasswordViewController:UIViewController{
    private let changePasswordView = ChangePasswordView()
    private let viewModel :ChangePasswordViewModel
    private let coordinator: ForgotPasswordCoordinator
    private var cancellables = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = changePasswordView
        setupBindings()
        setupActions()
        setupUI()
    }
    private func setupUI() {
        view.addSubview(changePasswordView)
        changePasswordView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    init(viewModel: ChangePasswordViewModel, coordinator: ForgotPasswordCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindings() {
        viewModel.isPasswordValidPublisher
            .sink { [weak self] isValid in
                self?.changePasswordView.infoLabel.textColor = isValid ? .systemGreen : .systemRed
                self?.changePasswordView.infoLabel.text = isValid ?
                "Şifrə güclüdür" : "Şifrə ən azı 6 simvol olmalıdır"
                self?.changePasswordView.changePasswordButton.isEnabled = isValid
                self?.changePasswordView.changePasswordButton.alpha = isValid ? 1.0 : 0.5
            }
            .store(in: &cancellables)
    }
    
    private func setupActions() {
        changePasswordView.passwordTextField.addTarget(self, action: #selector(passwordTextChanged), for: .editingChanged)
        changePasswordView.changePasswordButton.addTarget(self, action: #selector(changePasswordTapped), for: .touchUpInside)
    }
    
    @objc
    private func passwordTextChanged(_ sender: UITextField) {
        viewModel.password = sender.text ?? ""
    }
    
    @objc
    private func changePasswordTapped() {
        viewModel.changePassword { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.viewModel.didSuccessfullyChangePassword()
                case .failure(let error):
                    self?.showError(error)
                    
                }
            }
        }
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Xəta", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}
