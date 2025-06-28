//
//  SecurePaymentBuilder.swift
//  LucaryShop
//
//  Created by User on 28.06.25.
//

import UIKit

final class SecurePaymentBuilder{
    private let cartService: CartService
    var coordinator:SecurePaymentCoordinator
    
    
    init(cartService: CartService, coordinator: SecurePaymentCoordinator) {
        self.cartService = cartService
        self.coordinator = coordinator
    }
    
    func build () -> UIViewController {
        let viewmodel = SecurePaymentViewModel(cartService: cartService, coordinator: coordinator)
        let vc  = SecurePaymentViewController(securePaymentViewModel: viewmodel)
        return vc
    }
    
}
