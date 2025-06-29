//
//  AboutCoordinator.swift
//  LucaryShop
//
//  Created by User on 29.06.25.
//

import Foundation
import UIKit
final class AboutCoordinator{
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    
    init(parentCoordinator: AppCoordinator? = nil,
         navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        let builder = AboutBuilder(coordinator: self)
        let vc = builder.build()
        navigationController.pushViewController(vc, animated: true)
    }
}
