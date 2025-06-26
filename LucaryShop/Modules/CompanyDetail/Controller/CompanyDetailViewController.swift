//
//  CompanyDetailViewController.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//

import Foundation
import UIKit
final class CompanyDetailViewController:UIViewController {
    private lazy var categoryView = CompanyDetailView()
    private let viewModel: CompanyDetailViewModel

    init(viewModel: CompanyDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

  
    override func loadView() {
        self.view = categoryView
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .verifyBg
        navigationItem.hidesBackButton = true

    }

   

  
  
}
