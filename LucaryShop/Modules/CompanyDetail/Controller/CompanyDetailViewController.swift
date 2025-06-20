//
//  CompanyDetailViewController.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//

import Foundation
import UIKit
final class CompanyDetailViewController:UIViewController {
    private let companyDetailView = CompanyDetailView()
    private let viewModel:CompanyDetailViewModel
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: CompanyDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
