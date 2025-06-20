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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }

    func start() {
//        let homeNav = UINavigationController()
//        let homeCoordinator = HomeCoordinator(parentCoordinator: <#T##AppCoordinator?#>, navigationController: <#T##UINavigationController#>, productService: <#T##ProductService#>, categoryService: <#T##CategoryService#>) { 
//            <#code#>
//        }
//
//        let orderNav = UINavigationController()
//        let orderCoordinator = OrderCoordinator(navigationController: orderNav)
//
//        let favoriteNav = UINavigationController()
//        let favoriteCoordinator = FavoritesCoordinator(navigationController: favoriteNav)
//
//        let profileNav = UINavigationController()
//        let profileCoordinator = ProfileCoordinator(navigationController: profileNav)
//
//        homeCoordinator.start()
//        orderCoordinator.start()
//        favoriteCoordinator.start()
//        profileCoordinator.start()

        tabBarController.viewControllers = [
//            homeNav,
//            orderNav,
//            favoriteNav,
//            profileNav
        ]

        tabBarController.tabBar.tintColor = .systemPurple
        configureTabBarItems()

        navigationController.setViewControllers([tabBarController], animated: true)
    }

    private func configureTabBarItems() {
        tabBarController.viewControllers?[0].tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        tabBarController.viewControllers?[1].tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "cube.box"), tag: 1)
        tabBarController.viewControllers?[2].tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 2)
        tabBarController.viewControllers?[3].tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 3)
    }
}
