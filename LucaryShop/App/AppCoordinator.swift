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
// MARK: - Flow Types
enum AuthFlowType { case login, register, forgotPassword }
enum TabbarFlowType { case home, company, cart, favorites, profile }
enum HomeCategoryFlowType { case home, category }



final class AppCoordinator: Coordinator {
    // MARK: - Dependencies
    private let authService: AuthService
    private let verificationId: String
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    
    
    
    // MARK: - Coordinators
    private var mainTabBarCoordinator: MainTabBarCoordinator?
    private var productDetailCoordinator: ProductDetailCoordinator?
    private var aboutCoordinator: AboutCoordinator?
    private var termsCoordinator: TermsCoordinator?
    private var profileCoordinator: ProfileCoordinator?
    var childCoordinators: [Coordinator] = []
    
    
    
    // MARK: - State
    private var isHomeFlowInProgress = false
    
    
    // MARK: - Loading View
    private var loadingView: UIView?
    private var loadingLabel: UILabel?
    private var loadingTimer: Timer?
    
    
    
    // MARK: - Init
    init(
        navigationController: UINavigationController,
        authService: AuthService,
        verificationId: String,
        parentCoordinator: Coordinator? = nil
    ) {
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Start
    func start() {
        authService.isLoggedIn()
        ? startHomeFlow(.home)
        : navigationController.setViewControllers([SplashBuild(cordinator: self).build()], animated: true)
    }
    
    func start(with categoryId: String) {
        //
    }
    
    // MARK: - Auth Flow
    func startAuthFlow(_ flow: AuthFlowType) {
        let coordinator: Coordinator
        switch flow {
        case .login:
            let login = LoginCoordinator(
                parentCoordinator: self,
                navigationController: navigationController,
                authService: authService,
                verificationId: verificationId
            )
            login.onFinish = { [weak self] in self?.startHomeFlow(.home) }
            coordinator = login as! any Coordinator
            
        case .register:
            let register = RegisterCoordinator(
                parentCoordinator: self,
                navigationController: navigationController,
                authService: authService
            )
            register.onFinish = { [weak self] in self?.startHomeFlow(.home) }
            coordinator = register as! any Coordinator
            
        case .forgotPassword:
            coordinator = ForgotPasswordCoordinator(
                parentCoordinator: self,
                navigationController: navigationController,
                authService: authService,
                verificationId: verificationId
            ) as! any Coordinator
        }
        
        coordinator.start()
    }
    
    func didFinishForgotPasswordFlow() {
        guard !(navigationController.topViewController is LoginViewController) else { return }
        startAuthFlow(.login)
    }
    
    
    // MARK: - Onboarding
    func goToPermissionsOnboarding() {
        let vc = PermissionsOnboardingBuilder(coordinator: self).build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToGetStartedOnboarding() {
        let vc = GetStartedOnboardingBuilder(coordinator: self).build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Home Flow
    func startHomeFlow(_ flow: TabbarFlowType) {
        guard !isHomeFlowInProgress else { return }
        
        isHomeFlowInProgress = true
        resetTabBar()
        showLoadingIndicator()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.hideLoadingIndicator()
            let tabBarController = UITabBarController()
            let coordinator = MainTabBarCoordinator(
                parentCoordinator: self,
                navigationController: self.navigationController,
                tabBarController: tabBarController,
                productService: ProductService(),
                categoryService: CategoryService(),
                companyService: CompanyService(),
                orderService: OrderService(),
                favoriteService: FavoritesService(),
                authService: self.authService,
                profileService: ProfileService(),
                cartService: CartService()
            )
            self.mainTabBarCoordinator = coordinator
            self.childCoordinators.append(coordinator)
            coordinator.start()
            
            tabBarController.selectedIndex = flow.tabIndex
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
        if let coordinator = mainTabBarCoordinator {
            print("MainTabBarCoordinator reset edilir.")
            childCoordinators.removeAll { $0 === coordinator }
            mainTabBarCoordinator = nil
        }
        navigationController.setViewControllers([], animated: false)
    }
    
    // MARK: - Loading Indicator
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
    
    // MARK: - Language Change
    @objc private func languageDidChange() {
        let lang = LocalizationManager.shared.currentLanguage
        print("Dil dəyişdi: \(lang.rawValue)")
        Bundle.setLanguage(lang.rawValue)
        mainTabBarCoordinator?.updateTextsForLanguage() ?? startHomeFlow(.home)
    }
    
    // Child Coordinator
    func childDidFinish(_ child: Coordinator) {
        childCoordinators.removeAll { $0 === child }
    }
}

// TabbarFlowType Extension
private extension TabbarFlowType {
    var tabIndex: Int {
        switch self {
        case .home: return 0
        case .company: return 1
        case .cart: return 2
        case .favorites: return 3
        case .profile: return 4
        }
    }
}
