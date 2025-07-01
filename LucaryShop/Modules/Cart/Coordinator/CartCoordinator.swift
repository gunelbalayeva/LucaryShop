//
//  CartCoordinator.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//
import UIKit
final class CartCoordinator{
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let cartService: CartService
    let orderService: OrderService
    var onFinish: (() -> Void)?
    
    init(parentCoordinator: Coordinator? = nil,
         navigationController: UINavigationController,
         cartService: CartService,
         orderService: OrderService) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.cartService = cartService
        self.orderService = orderService
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
                                                         cartService: cartService,
                                                         orderService: orderService
        )
        secureCoordinator.start()
        
    }
    
    
    func startAndReturnViewController() -> UIViewController {
        let vc = CartBuilder(cartService: cartService,
                             coordinator: self).build()
        return UINavigationController(rootViewController: vc)
    }
    
    func finish() {
        onFinish?()
    }
}
