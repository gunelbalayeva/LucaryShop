//
//  ProfileViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
import Combine
final class ProfileViewController:UIViewController{
    private let profileView = ProfileView()
    private let viewModel : ProfileViewModel
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupBindings()
        bindViewModel()
        viewModel.fetchProfile()
    }
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        self.view = profileView
    }
    
    private func setupBindings() {
        NotificationCenter.default.addObserver(self,
               selector: #selector(languageDidChange),
               name: .appLanguageDidChange,
               object: nil)
        profileView.onTappedEdited = { [weak self] in
            self?.viewModel.openEditProfile()
        }
        
        profileView.onTappedLanguaceScreenButton = { [weak self] in
            self?.viewModel.openLanguageScreen()
        }

        profileView.onOrdersButton = { [weak self] in
            self?.viewModel.openOrders()
        }

        profileView.onTappedAboutUs = { [weak self] in
            self?.viewModel.openAboutUs()
        }

        profileView.onTappedTermsScreen = { [weak self] in
            self?.viewModel.openTerms()
        }

        profileView.onTappedLogout = { [weak self] in
            self?.showLogoutAlert()
        }
    }
    
    
    private func bindViewModel() {
        viewModel.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let user = user else { return }
                self?.profileView.userNameLabel.text = user.name
                self?.profileView.surnameLabel.text = user.surname
                self?.profileView.emailLabel.text = user.email
            }
            .store(in: &cancellables)
    }


    private func showLogoutAlert() {
        let alert = UIAlertController(
            title: LocalizedStrings.logoutTitle,
            message: LocalizedStrings.logoutMessage,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(
            title: LocalizedStrings.logoutCancel,
            style: .cancel,
            handler: nil
        ))
        
        alert.addAction(UIAlertAction(
            title: LocalizedStrings.logoutConfirm,
            style: .destructive,
            handler: { [weak self] _ in
                self?.viewModel.logout()
            }
        ))

        present(alert, animated: true)
    }

    
    @objc
    private func languageDidChange() {
        updateTextsForCurrentLanguage()
    }

    func updateTextsForCurrentLanguage() {
        profileView.editedAccountButton.setTitle(LocalizedStrings.editedAccountButton, for: .normal)
        profileView.goToLanguaceScreenButton.setTitle(LocalizedStrings.goToLanguageScreenButton, for: .normal)
        profileView.goToOrdersButton.setTitle(LocalizedStrings.goToOrdersButton, for: .normal)
        profileView.goToAboutUsScreenButton.setTitle(LocalizedStrings.goToAboutUsScreenButton, for: .normal)
        profileView.goToTermsScreenButton.setTitle(LocalizedStrings.goToTermsScreenButton, for: .normal)
        profileView.goToLogoutScreenButton.setTitle(LocalizedStrings.goToLogoutScreenButton, for: .normal)   
    }
}
