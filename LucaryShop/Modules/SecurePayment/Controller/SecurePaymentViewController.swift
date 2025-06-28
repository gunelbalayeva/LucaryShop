//
//  SecurePaymentViewController.swift
//  LucaryShop
//
//  Created by User on 28.06.25.
//

import UIKit
final class SecurePaymentViewController:UIViewController{
    let securePaymentViewModel:SecurePaymentViewModel
    let securePaymentView = SecurePaymentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func loadView() {
        self.view = securePaymentView
    }
    
    
    init(securePaymentViewModel: SecurePaymentViewModel) {
        self.securePaymentViewModel = securePaymentViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
