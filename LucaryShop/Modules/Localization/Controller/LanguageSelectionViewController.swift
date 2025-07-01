//
//  LanguageSelectionViewController.swift
//  LucaryShop
//
//  Created by User on 17.06.25.
//
import UIKit
final class LanguageSelectionViewController:UIViewController {
    
    private let languageView = LanguageSelectionView()
    let viewModel: LanguageSelectionViewModel
    private let coordinator: LanguageSelectionCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        setupTableView()
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
    
    @objc
    private func languageDidChange() {
        print("Language changed!") 
        updateTextsForCurrentLanguage()
    }
    
    private func setupView() {
        view.backgroundColor = .verifyBg
        title = "Tətbiq dili"
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(languageDidChange),
                name: .appLanguageDidChange,
                object: nil
            )
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    
    private func setupTableView() {
        languageView.tableView.dataSource = self
        languageView.tableView.delegate = self
        languageView.tableView.reloadData()
    }
    
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func updateTextsForCurrentLanguage() {
        title = LocalizedStrings.languageTitle
       
    }
}


