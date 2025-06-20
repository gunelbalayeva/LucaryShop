//
//  ProductListViewController.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//

import Foundation
import UIKit
final class ProductListViewController:UIViewController {
    private let productListVie = ProductListView()
    private let viewModel: ProductListViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
