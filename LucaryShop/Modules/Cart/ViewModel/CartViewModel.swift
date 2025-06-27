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
    @Published var shouldUpdateCells: Bool = false

    init(cartService: CartService, coordinator: CartCoordinator) {
        self.cartService = cartService
        self.coordinator = coordinator
    }
    
    func fetchCart() {
           isLoading = true
           cartService.getCart { [weak self] result in
               DispatchQueue.main.async {
                   self?.isLoading = false
                   switch result {
                   case .success(let response):
                       self?.cartItems = response.products
                       self?.calculateTotalPrice()
                   case .failure(let error):
                       self?.errorMessage = error.localizedDescription
                   }
               }
           }
       }
    
    func increaseQuantity(for productId: String) {
        guard let item = cartItems.first(where: { $0.id == productId }) else { return }
        let newQuantity = item.quantity + 1

        isLoading = true
        cartService.addToCart(productId: productId, quantity: newQuantity) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.cartItems = response.products
                    self?.totalPrice = response.totalPrice
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func decreaseQuantity(for productId: String) {
        guard let item = cartItems.first(where: { $0.id == productId }), item.quantity > 1 else { return }
        let newQuantity = item.quantity - 1

        isLoading = true
        cartService.addToCart(productId: productId, quantity: newQuantity) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.cartItems = response.products
                    self?.totalPrice = response.totalPrice
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func removeItemFromCart(with productId: String) {
        isLoading = true
        cartService.removeFromCart(productId: productId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.cartItems = response.products
                    self?.totalPrice = response.totalPrice
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    
    private func calculateTotalPrice() {
        totalPrice = cartItems.reduce(0) { result, item in
            result + (item.price * Double(item.quantity))
        }
    }
}
