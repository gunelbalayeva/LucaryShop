//
//  LanguageSelectionCoordinator.swift
//  LucaryShop
//
//  Created by User on 17.06.25.
//

import Foundation
import UIKit

final class LanguageSelectionCoordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    
    func startLanguage() {
        let vc = LanguageSelectionBuilder(cordinator: self).build()
        navigationController.pushViewController(vc, animated: true)
    }
}
