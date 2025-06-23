//
//  AppCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

// gunelbalayeva97@gmail.com
// gunel12345

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

enum HomeCategoryFlowType{
    case home
    case category
}

enum ProductFlowType{
    case productDetail
    case cart
    
}

enum ProfileFlowType {
    case language
}


final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let authService: AuthService
    let verificationId: String
    private var childCoordinators: [Coordinator] = []
   
    
    
    init(navigationController: UINavigationController, authService: AuthService, verificationId: String) {
        self.navigationController = navigationController
        self.authService = authService
        self.verificationId = verificationId
    
    }
    
    func childDidFinish(_ child: Coordinator) {
        childCoordinators.removeAll { $0 === child }
    }
    
    func start() {
      startHomeFlow(.home)
//        print("🏁 AppCoordinator startHomeFlow çağırıldı")
//
//                let vc = SplashBuild(cordinator: self).build()
//                navigationController.setViewControllers([vc], animated: true)
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
                parentCoordinator: self,
                navigationController: navigationController,
                authService: authService,
                verificationId: verificationId)
            loginCoordinator.onFinish = { [weak self] in
                self?.startHomeFlow(.home)
            }
            loginCoordinator.start()
            
        case .register:
            let registerCoordinator = RegisterCoordinator(
                parentCoordinator:self, 
                navigationController: navigationController,
                authService: authService)
            registerCoordinator.onFinish = { [weak self] in
                print("Hello Home - men bosam deye cagirilmiram")
                self?.startHomeFlow(.home)
            }
            registerCoordinator.start()
        case .forgotPassword:
            let forgotCoordinator = ForgotPasswordCoordinator(
                parentCoordinator:self,
                navigationController: navigationController,
                authService: authService,
                verificationId: verificationId)
            forgotCoordinator.start()
        }
    }
    
    
    func didFinishForgotPasswordFlow() {
        if !(navigationController.topViewController is LoginViewController) {
            startAuthFlow(.login)
        }
    }
    
    
    func startHomeFlow(_ flow :TabbarFlowType) {
        print("🏁 MainTabBarCoordinator start çağırıldı")
        
            let productService = ProductService()
            let categoryService = CategoryService()
            let companyService = CompanyService()
            let orderService = OrderService()
            let favoriteService = FavoritesService()
            let profileService = ProfileService()
            let cartService = CartService()
            let tabBarController = UITabBarController()
            let mainTabBarCoordinator = MainTabBarCoordinator(
                parentCoordinator: self,
                navigationController: navigationController,
                tabBarController: tabBarController,
                productService: productService,
                categoryService: categoryService,
                companyService: companyService,
                orderService: orderService,
                favoriteService: favoriteService,
                authService: authService,
                profileService: profileService,
                cartService: cartService
            )
            childCoordinators.append(mainTabBarCoordinator)
            mainTabBarCoordinator.start()
            switch flow {
            case .home:
                tabBarController.selectedIndex = 0
            case .order:
                tabBarController.selectedIndex = 1
            case .favorites:
                tabBarController.selectedIndex = 2
            case .profile:
                tabBarController.selectedIndex = 3
            }
        }
        
   
        func startProfile(_ flow :ProfileFlowType){
            switch flow {
            case .language:
                let languageCoordinator = LanguageSelectionCoordinator(
                    parentCoordinator: self,
                    navigationController: navigationController)
                languageCoordinator.startLanguage()
            }
        }
    }

