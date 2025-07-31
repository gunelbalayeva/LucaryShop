//
//  AppCoordinator.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//
//muzaffarbalayev@gmail.com
//muzaffar1234
// gunelbalayeva97@gmail.com
// gunel1234

// nazlibalayeva0@gmail.com
// nazli1234

import Foundation
import UIKit
enum AuthFlowType {
    case login
    case register
    case forgotPassword
}

enum TabbarFlowType {
    case home
    case company
    case cart
    case favorites
    case profile
}

enum HomeCategoryFlowType{
    case home
    case category
}

final class AppCoordinator: Coordinator {
    private let authService: AuthService
    private var mainTabBarCoordinator: MainTabBarCoordinator?
    private var loadingView: UIView?
    private var loadingLabel: UILabel?
    private var loadingTimer: Timer?
    private var isHomeFlowInProgress = false
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var productDetailCoordinator: ProductDetailCoordinator?
    var aboutCoordinator:AboutCoordinator?
    var termsCoordinator:TermsCoordinator?
    var profilecoordinator:ProfileCoordinator?
    weak var parentCoordinator: Coordinator?
    let verificationId: String
    
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
        if authService.isLoggedIn() {
            startHomeFlow(.home)
        } else {
            let vc = SplashBuild(cordinator: self).build()
            navigationController.setViewControllers([vc], animated: true)
        }
    }
    
    func start(with categoryId: String) {
        
    }
    
    @objc
    func languageDidChange() {
        let lang = LocalizationManager.shared.currentLanguage
        print("Dil dəyişdi: \(lang.rawValue)")
        Bundle.setLanguage(lang.rawValue)
        if let existingCoordinator = self.mainTabBarCoordinator {
            existingCoordinator.updateTextsForLanguage()
        } else {
            startHomeFlow(.home)
        }
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
    
    private func showLoadingIndicator() {
        hideLoadingIndicator()
        let loadingView = UIView(frame: UIScreen.main.bounds)
        loadingView.backgroundColor = UIColor(named: "Verify")
        let label = UILabel()
        label.text = "Loading"
        label.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        label.textColor = UIColor(named: "baseButton")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.addSubview(loadingView)
        }
        self.loadingView = loadingView
        self.loadingLabel = label
        var dotCount = 0
        loadingTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            dotCount = (dotCount + 1) % 4
            self?.loadingLabel?.text = "Loading" + String(repeating: ".", count: dotCount)
        }
    }
    
    private func hideLoadingIndicator() {
        loadingTimer?.invalidate()
        loadingTimer = nil
        loadingLabel = nil
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
    
    func startHomeFlow(_ flow: TabbarFlowType) {
        guard !isHomeFlowInProgress else {
            return
        }
        isHomeFlowInProgress = true
        resetTabBar()
        showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.hideLoadingIndicator()
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
                navigationController: self.navigationController,
                tabBarController: tabBarController,
                productService: productService,
                categoryService: categoryService,
                companyService: companyService,
                orderService: orderService,
                favoriteService: favoriteService,
                authService: self.authService,
                profileService: profileService,
                cartService: cartService )
            self.mainTabBarCoordinator = mainTabBarCoordinator
            self.childCoordinators.append(mainTabBarCoordinator)
            mainTabBarCoordinator.start()
            switch flow {
            case .home: tabBarController.selectedIndex = 0
            case .company: tabBarController.selectedIndex = 1
            case .cart: tabBarController.selectedIndex = 2
            case .favorites: tabBarController.selectedIndex = 3
            case .profile: tabBarController.selectedIndex = 4
            }
            self.isHomeFlowInProgress = false
        }
    }
   
    func resetToLogin() {
        childCoordinators.removeAll()
        mainTabBarCoordinator = nil
        navigationController.setViewControllers([], animated: false)
        startAuthFlow(.login)
    }
        
    func resetTabBar() {
        if let existingCoordinator = mainTabBarCoordinator {
            print("MainTabBarCoordinator reset edilir.")
            childCoordinators.removeAll { $0 === existingCoordinator }
            mainTabBarCoordinator = nil
        }
        navigationController.setViewControllers([], animated: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
