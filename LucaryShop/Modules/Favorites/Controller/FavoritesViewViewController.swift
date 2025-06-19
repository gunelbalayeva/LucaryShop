//
//  FavoritesViewViewController.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
import UIKit
final class FavoritesViewViewController:UIViewController{
    
    private let favoriteView = UIView()
    private let viewModel :FavoritesViewModel
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
