//
//  CartCoordinator.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//
import UIKit
final class CartCoordinator{
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    let cartService: CartService
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: AppCoordinator? = nil, 
         navigationController: UINavigationController,
         cartService: CartService){
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.cartService = cartService
    }
    
    
    func start() {
        let builder = CartBuilder(cartService: cartService,
                                  coordinator: self)
        let vc = builder.build()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToSecurePayment(){
        let secureCoordinator = SecurePaymentCoordinator(parentCoordinator: parentCoordinator,
                                                         navigationController: navigationController,
                                                         cartService: cartService
        )
        secureCoordinator.start()
        
    }
    
  
    
    func finish() {
        onFinish?()
    }
}
