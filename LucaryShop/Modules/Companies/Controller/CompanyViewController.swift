//
//  CompanyViewController.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//

import Foundation
import UIKit
final class CompanyViewController:UIViewController{
    
    private let companyView = CartView()
    private let viewModel:CompanyViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: CompanyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
