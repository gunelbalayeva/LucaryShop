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
    private var homeCoordinator: HomeCoordinator?
    private var orderCoordinator: OrderCoordinator?
    private var favoriteCoordinator: FavoritesCoordinator?
    private var profileCoordinator: ProfileCoordinator?
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
        let homeCoordinator = HomeCoordinator(parentCoordinator: parentCoordinator,
                                              navigationController: homeNav,
                                              productService: productService,
                                              categoryService: categoryService,
                                              companyService: companyService,
                                              cartService: cartService,
                                              favoritesService: favoriteService)
        self.homeCoordinator = homeCoordinator
        homeCoordinator.start()
        // 2.Order
        let orderNav = UINavigationController()
        let orderCoordinator = OrderCoordinator(parentCoordinator: parentCoordinator,
                                                navigationController: orderNav,
                                                orderService: orderService)
        self.orderCoordinator = orderCoordinator
        orderCoordinator.start()
        
        // 3.Favorite
        let favoriteNav = UINavigationController()
        let favoriteCoordinator = FavoritesCoordinator(parentCoordinator: parentCoordinator,
                                                       navigationController: favoriteNav,
                                                       profileService: profileService,
                                                       favoriteService: favoriteService,
                                                       productService: productService,
                                                       cartService: cartService)
        self.favoriteCoordinator = favoriteCoordinator
        favoriteCoordinator.start()
        
        //4. Profile
        let profileNav = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNav,
                                                    profileService: profileService,
                                                    authService: authService)
        self.profileCoordinator = profileCoordinator
        profileCoordinator.start()
        tabBarController.viewControllers = [homeNav, orderNav, favoriteNav, profileNav]
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



