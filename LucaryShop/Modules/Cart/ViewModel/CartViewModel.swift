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
     var coordinator: CartCoordinator
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
                       self?.totalPrice = response.totalPrice
                   case .failure(let error):
                       self?.errorMessage = error.localizedDescription
                   }
               }
           }
       }
    
    func updateCart(productId: String, quantity: Int, completion: (() -> Void)? = nil) {
        isLoading = true
        cartService.addToCart(productId: productId, quantity: quantity) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.cartItems = response.products
                    self?.totalPrice = response.totalPrice
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
                completion?()
            }
        }
    }

    
    func increaseQuantity(for productId: String) {
        guard let item = cartItems.first(where: { $0.id == productId }) else { return }
        updateCart(productId: productId, quantity: item.quantity + 1)
    }

    func decreaseQuantity(for productId: String) {
        guard let item = cartItems.first(where: { $0.id == productId }), item.quantity > 1 else { return }
        updateCart(productId: productId, quantity: item.quantity - 1)
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

    func prepareCartForCheckout(completion: @escaping () -> Void) {
        isLoading = true
        let group = DispatchGroup()

        for item in cartItems {
            group.enter()
            updateCart(productId: item.id, quantity: item.quantity) {
                group.leave()
            }
        }

        group.notify(queue: .main) { [weak self] in
            self?.isLoading = false
            completion()
        }
    }
}
