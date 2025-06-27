//
//  CartViewModel.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//
import Foundation
import Combine

final class CartViewModel {
    private let cartService: CartService
    private var coordinator: CartCoordinator
    @Published var cartItems: [CartItem] = []
    @Published var totalPrice: Double = 0.0
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(cartService: CartService, coordinator: CartCoordinator) {
        self.cartService = cartService
        self.coordinator = coordinator
    }
//    
//    func getCart() {
//        isLoading = true
//        cartService.getCart { [weak self] result in
//            DispatchQueue.main.async {
//                self?.isLoading = false
//                switch result {
//                case .success(let items):
//                    self?.cartItems = items
//                    self?.calculateTotalPrice()
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//    
//    func removeItem(productId: Int) {
//        cartService.removeFromCart(productId: productId) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success:
//                    self?.cartItems.removeAll { $0.productId == productId }
//                    self?.calculateTotalPrice()
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//    
//    func checkout(address: String, paymentMethod: String) {
//        _ = CheckoutRequest(address: address, paymentMethod: paymentMethod)
//        cartService.checkout { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success:
//                    self?.cartItems = []
//                    self?.totalPrice = 0
//                    self?.coordinator?.navigateToOrders()
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
    
    private func calculateTotalPrice() {
        totalPrice = cartItems.reduce(0) { result, item in
            result + (item.price * Double(item.quantity))
        }
    }
}
