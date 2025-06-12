//
//  ChangePasswordViewController  .swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit
final class ChangePasswordViewController:UIViewController{
    
    private let changePasswordView = ChangePasswordView()
    private let viewModel :ChangePasswordViewModel
    private let coordinator: ForgotPasswordCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    init(viewModel: ChangePasswordViewModel, coordinator: ForgotPasswordCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
