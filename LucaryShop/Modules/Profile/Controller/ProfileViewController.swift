//
//  ProfileViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class ProfileViewController:UIViewController{
    private let profileView = ProfileView()
    private let viewModel : ProfileViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupBindings()
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
            self?.viewModel.logout()
        }
    }

}
