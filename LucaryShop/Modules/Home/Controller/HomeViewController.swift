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
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 240)
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
        observeViewModel()
        setupFavoriteSubscriptions()
     homeViewModel.fetchHomeData()
        setupFavoriteNotifications()
        if let token = KeychainManager.shared.getToken() {
            print("Token home: \(token)")
        } else {
            print("Token tapılmadı")
        }

        
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
        companiesCollectionView.register(CompanyCell.self, forCellWithReuseIdentifier: CompanyCell.identifier)
        productList.dataSource = self
        productList.delegate = self
        productList.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
    }
    
    func updateSelectedIndex(_ index: Int) {
        homeView.selectedIndex = index
        homeView.updateUnderlinePosition()
    }
    
    
    private func setupActions() {
        homeView.onCategoriesTapped = { [weak self] in
            self?.homeViewModel.navigateToCompanies()
        }
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
    
    func updateFavoriteStatus(for productId: String, isFavorite: Bool) {
        homeViewModel.updateFavoriteStatus(for: productId, isFavorite: isFavorite)
    }
    
    private func setupFavoriteNotifications() {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(handleFavoriteChange(_:)),
                name: FavoritesService.favoritesDidChangeNotification,
                object: nil
            )
        }
        
    private func setupFavoriteSubscriptions() {
            homeViewModel.favoritesService.favoritesChangePublisher
                .sink { [weak self] (productId, isFavorite) in
                    self?.homeViewModel.updateFavoriteStatus(for: productId, isFavorite: isFavorite)
                }
                .store(in: &cancellables)
        }
    
        @objc
    private func handleFavoriteChange(_ notification: Notification) {
            if let userInfo = notification.userInfo,
               let productId = userInfo["productId"] as? String,
               let isFavorite = userInfo["isFavorite"] as? Bool {
                homeViewModel.updateFavoriteStatus(for: productId, isFavorite: isFavorite)
            }
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
}
