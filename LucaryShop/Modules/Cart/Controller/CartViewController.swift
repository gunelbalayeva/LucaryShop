//
//  CartViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
final class CartViewController:UIViewController {
    private let productDetailView = CartView()
    private let viewModel:CartViewModel
    private let coordinator: CartCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: CartViewModel, coordinator: CartCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
