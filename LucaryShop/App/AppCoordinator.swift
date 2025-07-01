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


enum AuthFlowType {
    case login
    case register
    case forgotPassword
}


enum TabbarFlowType {
    case home
    case cart
    case favorites
    case profile
}

enum HomeCategoryFlowType{
    case home
    case category
}

final class AppCoordinator: Coordinator {
    func start(with categoryId: String) {
        
    }
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let authService: AuthService
    let verificationId: String
    var productDetailCoordinator: ProductDetailCoordinator?
    var aboutCoordinator:AboutCoordinator?
    var termsCoordinator:TermsCoordinator?
    var profilecoordinator:ProfileCoordinator?
    private var mainTabBarCoordinator: MainTabBarCoordinator?
    weak var parentCoordinator: Coordinator?

    init(navigationController: UINavigationController,
         authService: AuthService,
         verificationId: String,
         parentCoordinator: Coordinator? = nil) {
        self.navigationController = navigationController
        self.authService = authService
        self.verificationId = verificationId
        self.parentCoordinator = parentCoordinator
        NotificationCenter.default.addObserver(
                   self,
                   selector: #selector(languageDidChange),
                   name: .appLanguageDidChange,
                   object: nil
               )
    }
    
    func childDidFinish(_ child: Coordinator) {
        childCoordinators.removeAll { $0 === child }
    }

    
    func start() {
        
        startHomeFlow(.home)
//        let vc = SplashBuild(cordinator: self).build()
//            navigationController.setViewControllers([vc], animated: true)
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
    
    func startHomeFlow(_ flow: TabbarFlowType) {
        if let mainTabBarCoordinator = self.mainTabBarCoordinator {
            print("MainTabBarCoordinator artıq mövcuddur.")
            switch flow {
            case .home:
                mainTabBarCoordinator.tabBarController.selectedIndex = 0
            case .cart:
                mainTabBarCoordinator.tabBarController.selectedIndex = 1
            case .favorites:
                mainTabBarCoordinator.tabBarController.selectedIndex = 2
            case .profile:
                mainTabBarCoordinator.tabBarController.selectedIndex = 3
            }
            return
        }
        if let existingCoordinator = mainTabBarCoordinator {
               print("Mövcud MainTabBarCoordinator silinir.")
               childCoordinators.removeAll { $0 === existingCoordinator }
               mainTabBarCoordinator = nil
           }
        print("Yeni MainTabBarCoordinator yaradılır.")
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
        self.mainTabBarCoordinator = mainTabBarCoordinator
        childCoordinators.append(mainTabBarCoordinator)
        mainTabBarCoordinator.start()

        switch flow {
        case .home:
            tabBarController.selectedIndex = 0
        case .cart:
            tabBarController.selectedIndex = 1
        case .favorites:
            tabBarController.selectedIndex = 2
        case .profile:
            tabBarController.selectedIndex = 3
        }
    }
}

