//
//  AppCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import UIKit

protocol Coordinator:AnyObject {
    func start()
}

enum AuthFlowType {
    case login
    case register 
    case forgotPassword
}

enum TabbarFlowType {
    case home
    case order
    case favorites
    case profile
}

enum ProfileFlowType {
    case language
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let authService: AuthService
    let verificationId: String
    
    init(navigationController: UINavigationController, authService: AuthService, verificationId: String) {
        self.navigationController = navigationController
        self.authService = authService
        self.verificationId = verificationId
    }
    
    func start() {
        let vc = SplashBuild(cordinator: self).build()
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func goToPermissionsOnboarding() {
        let vc = PermissionsOnboardingBuilder(coordinator: self).build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToGetStartedOnboarding() {
        let vc = GetStartedOnboardingBuilder(coordinator: self).build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func startAuthFlow(_ flow: AuthFlowType) {
        switch flow {
        case .login:
            let loginCoordinator = LoginCoordinator(
                parentCoordinator: self, navigationController: navigationController, authService: authService, verificationId: verificationId)
            loginCoordinator.onFinish = { [weak self] in
                self?.startHomeFlow(.home)
            }
            loginCoordinator.start()
            
        case .register:
            let registerCoordinator = RegisterCoordinator(
                parentCoordinator:self, navigationController: navigationController, authService: authService)
            registerCoordinator.onFinish = { [weak self] in
                print("Hello Home - men bosam deye cagirilmiram")
                self?.startHomeFlow(.home)
            }
            registerCoordinator.start()
            
        case .forgotPassword:
            let forgotCoordinator = ForgotPasswordCoordinator(
                parentCoordinator:self, navigationController: navigationController, authService: authService, verificationId: verificationId)
            forgotCoordinator.start()
        }
    }
    
    func didFinishForgotPasswordFlow() {
        if !(navigationController.topViewController is LoginViewController) {
            startAuthFlow(.login)
        }
    }
    
    func startHomeFlow(_ flow :TabbarFlowType) {
        //        switch flow{
        //        case .home :
        //
        //        case .order :
        //
        //        case .favorites:
        //
        //        case .profile :
        //
        //        }
    }
    
    func startProfile(_ flow :ProfileFlowType){
        switch flow {
        case .language:
            let languageCoordinator = LanguageSelectionCoordinator(
                parentCoordinator: self, navigationController: navigationController)
            languageCoordinator.startLanguage()
        }
    }
}
