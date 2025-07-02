//
//  UsersRegisterViewController.swift
//  LucaryShop
//
//  Created by User on 02.07.25.
//

import Foundation
import UIKit
final class UsersRegisterViewController:UIViewController{
    let usersRegisterViewModel :UsersRegisterViewModel
    let usersRegisterView = UsersRegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        binding()
    }
    
    init(usersViewModel: UsersRegisterViewModel) {
        self.usersRegisterViewModel = usersViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = usersRegisterView
    }
    
    private func setupNavigationBar() {
        let config = UIImage.SymbolConfiguration(weight: .heavy)
        let image = UIImage(systemName: "chevron.backward", withConfiguration: config)
        let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .darkGray
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func binding(){
        usersRegisterViewModel.fetchUser { [weak self] user in
            DispatchQueue.main.async {
                guard let user = user else { return }
                self?.usersRegisterView.configure(with: user)
            }
        }
        usersRegisterView.onCreateAccountTapped = { [weak self] in
            self?.registerButtonTapped()
        }
    }
    
    @objc
    private func registerButtonTapped() {
        let name = InputSanitizer.trimmed(usersRegisterView.nameTextField.text)
        let surname = InputSanitizer.trimmed(usersRegisterView.surnameTextField.text)
        let email = InputSanitizer.trimmed(usersRegisterView.emailTextField.text)
        
        guard isValidEmail(email) else {
            showError(AppRegisterError.invalidEmail.userMessage)
            return
        }
        usersRegisterViewModel.updateProfile(name: name, surname: surname, email: email) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.showSuccessAndNavigate(with: name)
                case .failure(let error):
                    self?.showErrorAnimation(message: AppRegisterError.invalidEmail.userMessage)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func showSuccessAndNavigate(with name: String) {
        let popup = SuccessUserRegisterPopup(frame: view.bounds, userName: name)
        view.addSubview(popup)
        popup.dismiss(after: 3.0) { [weak self] in
            self?.usersRegisterViewModel.coordinator?.goToProfileScreen()
        }
    }
    
    private func showErrorAnimation(message: String) {
        let popup = ErrorUserRegisterPopup(frame: view.bounds, message: message)
        view.addSubview(popup)
        popup.dismiss(after: 3.0)
    }
}
