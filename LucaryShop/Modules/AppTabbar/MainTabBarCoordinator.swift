//
//  MainTabBarCoordinator.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import UIKit
final class MainTabBarCoordinator: Coordinator {
    weak var parentCoordinator: AppCoordinator?
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
        let homeCoordinator = HomeCoordinator(parentCoordinator: parentCoordinator,
                                              navigationController: navigationController,
                                              productService: productService,
                                              categoryService: categoryService,
                                              companyService: companyService)
        let orderCoordinator = OrderCoordinator(parentCoordinator: parentCoordinator,
                                                navigationController: navigationController,
                                            orderService: orderService)
        let favoriteCoordinator = FavoritesCoordinator(parentCoordinator: parentCoordinator,
                                                       navigationController: navigationController,
                                                       profileService: profileService,
                                                       favoriteService: favoriteService,
                                                       productService: productService,
                                                       cartService: cartService)
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController,
                                                    profileService: profileService,
                                                    authService: authService)
        let homeVC = homeCoordinator.startAndReturnViewController()
        let orderVC = orderCoordinator.startAndReturnViewController()
        let favoriteVC = favoriteCoordinator.startAndReturnViewController()
        let profileVC = profileCoordinator.startAndReturnViewController()
        
        tabBarController.viewControllers = [homeVC, orderVC, favoriteVC, profileVC]
        tabBarController.tabBar.tintColor = .systemPurple
        configureTabBarItems()
        navigationController.setViewControllers([tabBarController], animated: true)
    }

    private func configureTabBarItems() {
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = UIColor(named: "logoColor")
        tabBarController.tabBar.unselectedItemTintColor = UIColor(named: "unSelectedTabbar")
        tabBarController.viewControllers?[0].tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        tabBarController.viewControllers?[1].tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "cube.box"), tag: 1)
        tabBarController.viewControllers?[2].tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 2)
        tabBarController.viewControllers?[3].tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 3)
    }

}

   

