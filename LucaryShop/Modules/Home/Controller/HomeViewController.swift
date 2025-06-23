//
//  HomeViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
import Combine

final class HomeViewController:UIViewController {
    
    let homeViewModel:HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    let companiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    let productList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 150)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    lazy var homeView = HomeView(
        companiesCollectionView: companiesCollectionView,
        productList: productList
    )
    
    
    override func loadView() {
        self.view = homeView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionViews()
        setupActions()
        homeViewModel.fetchHomeData()
        observeViewModel()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeView.selectedIndex = 0
        homeView.updateUnderlinePosition()
    }
    
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupCollectionViews() {
        companiesCollectionView.dataSource = self
        companiesCollectionView.delegate = self
        companiesCollectionView.register(UICollectionViewCell.self,
                                         forCellWithReuseIdentifier: CompanyCell.identifier)
        
        productList.dataSource = self
        productList.delegate = self
        productList.register(UICollectionViewCell.self,
                             forCellWithReuseIdentifier: ProductCell.identifier)
    }
    
    
    private func setupActions() {
        homeView.onCategoriesTapped = { [weak self] in
            guard let self = self else { return }
            self.homeViewModel.coordinator?.navigateToCategory()
        }
    }
    
    
    func updateSelectedIndex(_ index: Int) {
        homeView.selectedIndex = index
        homeView.updateUnderlinePosition()
    }
    
    
    private func observeViewModel() {
        homeViewModel.$newArrivals
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.productList.reloadData()
            }
            .store(in: &cancellables)
        
        homeViewModel.$companies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.companiesCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}
