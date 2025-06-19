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
    }
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
