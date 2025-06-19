//
//  CartBuilder.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import UIKit
final class CartBuilder {
    private let cartService: CartService
    private var coordinator: CartCoordinator
    
    init(cartService: CartService, coordinator: CartCoordinator) {
        self.cartService = cartService
        self.coordinator = coordinator
    }
    
    func build () -> UIViewController {
        let viewmodel = CartViewModel(cartService: cartService, coordinator: coordinator)
        let vc  = CartViewController(viewModel: viewmodel)
        return vc
    }
}
