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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print("CartViewController açıldı")
    }
    
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = productDetailView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
