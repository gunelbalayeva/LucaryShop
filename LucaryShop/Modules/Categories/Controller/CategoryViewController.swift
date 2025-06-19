//
//  CategoryViewController.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
import UIKit
final class CategoryViewController:UIViewController {
    private let categoryView = CategoryView()
    private let ViewModel:CategoryViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(ViewModel: CategoryViewModel) {
        self.ViewModel = ViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
