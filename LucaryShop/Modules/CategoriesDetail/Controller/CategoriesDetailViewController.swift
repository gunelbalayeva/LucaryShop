//
//  CategoriesDetailViewController.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import Foundation
import UIKit
import Combine
final class CategoriesDetailViewController:UIViewController{
    
    let categoriesDetailView = CategoriesDetailView()
    let viewModel:CategoriesDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        setupNavigationBar()
//        binding()
    }
    
    override func loadView() {
        self.view = categoriesDetailView
    }
    
    init(viewModel: CategoriesDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionViews() {
        view.backgroundColor = .systemBackground
        let collectionView = categoriesDetailView.categoriesCollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            CategoriesDetailCell.self,
            forCellWithReuseIdentifier: CategoriesDetailCell.identifier
        )
        collectionView.configureScrolling(hidesIndicators: true, enablesScroll: true)
    }
    
    func binding() {
        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.categoriesDetailView.categoriesCollectionView.reloadData()
            }
            .store(in: &cancellables)
        viewModel.$categoryName
            .receive(on: DispatchQueue.main)
            .sink { [weak self] name in
                guard let name = name else { return }
                self?.categoriesDetailView.configure(with: name)
            }
            .store(in: &cancellables)
        viewModel.fetchProducts()
    }
    
    private func setupNavigationBar() {
        let config = UIImage.SymbolConfiguration(weight: .heavy)
        let image = UIImage(systemName: "chevron.backward", withConfiguration: config)
        let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .darkGray
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
