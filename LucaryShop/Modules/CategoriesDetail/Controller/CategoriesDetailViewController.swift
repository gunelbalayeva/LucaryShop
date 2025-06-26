//
//  CategoriesDetailViewController.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import Foundation
import UIKit
final class CategoriesDetailViewController:UIViewController{
    
    private let categoriesDetailView = CategoriesDetailView()
    private let viewModel:CategoriesDetailViewModel
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: CategoriesDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
