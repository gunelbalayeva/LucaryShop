//
//  SecurePaymentViewModel.swift
//  LucaryShop
//
//  Created by User on 28.06.25.
//

import Foundation
final class SecurePaymentViewModel {
    private let cartService: CartService
     let coordinator: SecurePaymentCoordinator
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    init(cartService: CartService, coordinator: SecurePaymentCoordinator) {
        self.cartService = cartService
        self.coordinator = coordinator
    }

    func confirmOrder(completion: @escaping (Bool) -> Void) {
        isLoading = true
        cartService.confirmCart { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    completion(true)
                    self?.coordinator.finish()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
}
