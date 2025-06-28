//
//  SecurePaymentCoordinator.swift
//  LucaryShop
//
//  Created by User on 28.06.25.
//

import Foundation
import UIKit
final class SecurePaymentCoordinator {
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    let cartService: CartService
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: AppCoordinator? = nil, navigationController: UINavigationController, cartService: CartService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.cartService = cartService
       
    }
    
    func start() {
        let builder = SecurePaymentBuilder(cartService: cartService,
                                  coordinator: self)
        let vc = builder.build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finish() {
        onFinish?()
    }
}
