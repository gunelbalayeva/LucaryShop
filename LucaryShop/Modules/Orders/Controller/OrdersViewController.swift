//
//  OrdersViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class OrdersViewController:UIViewController {
    private let productDetailView = OrdersView()
    private let viewModel: OrdersViewModel
    private let coordinator: OrderCoordinator
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    init(viewModel: OrdersViewModel, coordinator: OrderCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
