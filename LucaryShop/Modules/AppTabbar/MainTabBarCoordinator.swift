//
//  MainTabBarCoordinator.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import UIKit

final class MainTabBarCoordinator:Coordinator {
    func start(with categoryId: String) {
        
    }
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    let productService: ProductService
    let categoryService: CategoryService
    let companyService: CompanyService
    let orderService: OrderService
    private let favoriteService: FavoritesService
    private let authService: AuthService
    private let profileService: ProfileService
    private let cartService: CartService?
    private var homeCoordinator: HomeCoordinator?
    private var orderCoordinator: OrderCoordinator?
    private var favoriteCoordinator: FavoritesCoordinator?
    private var profileCoordinator: ProfileCoordinator?
    private var cartCoordinator:CartCoordinator?
    private var companyCoordinator:CompanyCoordinator?
    
    init(parentCoordinator: AppCoordinator? = nil,
         navigationController: UINavigationController,
         tabBarController: UITabBarController,
         productService: ProductService,
         categoryService: CategoryService,
         companyService: CompanyService,
         orderService: OrderService,
         favoriteService: FavoritesService,
         authService: AuthService,
         profileService: ProfileService,
         cartService: CartService?) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.tabBarController = tabBarController
        self.productService = productService
        self.categoryService = categoryService
        self.companyService = companyService
        self.orderService = orderService
        self.favoriteService = favoriteService
        self.authService = authService
        self.profileService = profileService
        self.cartService = cartService
    }
    

    func start() {
        guard let cartService = cartService else {
            print("CartService yoxdur, tabbar başlatmaq olmur")
            return
        }
        // 1.Home
           let homeNav = UINavigationController()
           let homeCoordinator = HomeCoordinator(parentCoordinator: self,
                                                navigationController: homeNav,
                                                productService: productService,
                                                categoryService: categoryService,
                                                companyService: companyService,
                                                cartService: cartService,
                                                favoritesService: favoriteService,
                                                orderService: orderService)
           self.homeCoordinator = homeCoordinator
           childCoordinators.append(homeCoordinator)
           homeCoordinator.start()
        
        // 2. Company
        let companyNav = UINavigationController()
        let companyCoordinator = CompanyCoordinator(parentCoordinator: self,
                                                    navigationController: companyNav,
                                                    companyService: companyService,
                                                    productService: productService,
                                                    favoritesService: favoriteService,
                                                    cartService: cartService,
                                                    orderService: orderService)
        self.companyCoordinator = companyCoordinator
        childCoordinators.append(companyCoordinator)
        companyCoordinator.start()
        
        
        // 3.Cart
        let cartNav = UINavigationController()
        let cartCoordinator = CartCoordinator(navigationController: cartNav,
                                              cartService: cartService,
                                              orderService: orderService)
        self.cartCoordinator = cartCoordinator
        cartCoordinator.start()
        
        
        // 4.Favorite
        let favoriteNav = UINavigationController()
        let favoriteCoordinator = FavoritesCoordinator(parentCoordinator: self,
                                                       navigationController: favoriteNav,
                                                       profileService: profileService,
                                                       favoriteService: favoriteService,
                                                       productService: productService,
                                                       cartService: cartService,
                                                       orderService: orderService)
        self.favoriteCoordinator = favoriteCoordinator
        favoriteCoordinator.start()
        
        //5. Profile
        let profileNav = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNav,
                                                    profileService: profileService,
                                                    authService: authService,
                                                    orderService: orderService )
        self.profileCoordinator = profileCoordinator
        profileCoordinator.onFinish = { [weak self] in
            self?.parentCoordinator?.resetToLogin()
        }
        profileCoordinator.start()

        tabBarController.viewControllers = [homeNav, companyNav, cartNav, favoriteNav, profileNav]
        configureTabBarItems()
        navigationController.setViewControllers([tabBarController], animated: false)
    }
    
    func updateTextsForLanguage() {
        configureTabBarItems()
    }

    func configureTabBarItems() {
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.tabBar.tintColor = UIColor(named: "logoColor")
        tabBarController.tabBar.unselectedItemTintColor = UIColor(named: "unSelectedTabbar")

        tabBarController.viewControllers?[0].tabBarItem = UITabBarItem(title: LocalizedStrings.tabHome,
                                                                       image: UIImage(systemName: "house"), tag: 0)
        tabBarController.viewControllers?[1].tabBarItem = UITabBarItem(title: LocalizedStrings.partners,
                                                                       image: UIImage(systemName: "building.2"), tag: 1)
        tabBarController.viewControllers?[2].tabBarItem = UITabBarItem(title: LocalizedStrings.tabCart,
                                                                       image: UIImage(named: "sebet"), tag: 2)
        tabBarController.viewControllers?[3].tabBarItem = UITabBarItem(title: LocalizedStrings.tabFavorites,
                                                                       image: UIImage(systemName: "heart"), tag: 3)
        tabBarController.viewControllers?[4].tabBarItem = UITabBarItem(title: LocalizedStrings.tabProfile,
                                                                       image: UIImage(systemName: "person.circle"), tag: 4)
    }

    
    func childDidFinish(_ child: Coordinator) {
        childCoordinators.removeAll { $0 === child }
        
        if child === homeCoordinator {
            homeCoordinator = nil
        }
    }

    deinit {
        print("MainTabBarCoordinator silindi")
    }
}
