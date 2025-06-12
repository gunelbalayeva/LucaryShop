//
//  SendOTPViewBuilder.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//

import UIKit

final class SendOTPViewBuilder {
    private let cordinator :ForgotPasswordCoordinator
    
    init(cordinator: ForgotPasswordCoordinator) {
        self.cordinator = cordinator
    }
    
    func build () -> UIViewController {
        let viewmodel = SendOTPViewViewModel(cordinator: cordinator)
        let vc  = SendOTPViewController(viewModel: viewmodel, coordinator: cordinator)
        return vc
    }
}
