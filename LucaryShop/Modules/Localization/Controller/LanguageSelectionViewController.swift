//
//  LanguageSelectionViewController.swift
//  LucaryShop
//
//  Created by User on 17.06.25.
//

import UIKit

final class LanguageSelectionViewController:UIViewController {
    private let languageView = LanguageSelectionView()
    private let viewModel :LanguageSelectionViewModel
    private let coordinator: LanguageSelectionCoordinator
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

    }
    override func loadView() {
        self.view = languageView
    }
    
    init(viewModel: LanguageSelectionViewModel, coordinator: LanguageSelectionCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
