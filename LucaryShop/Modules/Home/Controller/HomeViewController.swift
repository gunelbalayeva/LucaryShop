//
//  HomeViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class HomeViewController:UIViewController {
    private let homeView = HomeView()
    private let homeViewModel:HomeViewModel
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
