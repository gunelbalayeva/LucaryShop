//
//  SplashBuild.swift
//  LucaryShop
//
//  Created by User on 10.06.25.
//

import UIKit

final class SplashBuild {
    private let cordinator :AppCoordinator
        
        init(cordinator: AppCoordinator) {
            self.cordinator = cordinator
        }
        
        func build () -> UIViewController {
            let viewmodel = SplashViewModel(cordinator: cordinator)
            let vc  = SplashViewController(viewModel: viewmodel, coordinator: cordinator)
            return vc
        }
}
