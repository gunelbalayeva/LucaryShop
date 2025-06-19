//
//  ProductDetailViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class ProductDetailViewController:UIViewController {
    private let productDetailView = ProductDetailView()
    private let viewModel:ProductDetailViewModel
    private let coordinator: ProductDetailCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: ProductDetailViewModel, coordinator: ProductDetailCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
