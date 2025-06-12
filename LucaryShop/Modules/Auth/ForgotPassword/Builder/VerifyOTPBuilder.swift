//
//  VerifyOTPViewBuilder.swift
//  LucaryShop
//
//  Created by User on 12.06.25.
//


import UIKit

final class VerifyOTPBuilder {
    private let cordinator :ForgotPasswordCoordinator
    
    init(cordinator: ForgotPasswordCoordinator) {
        self.cordinator = cordinator
    }
    
    func build () -> UIViewController {
        let viewmodel = VerifyOTPViewModel(cordinator: cordinator)
        let vc  = VerifyOTPViewController(viewModel: viewmodel, coordinator: cordinator)
        return vc
    }
}

