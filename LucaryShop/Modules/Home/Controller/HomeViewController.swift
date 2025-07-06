//
//  HomeViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
import Combine
final class HomeViewController:UIViewController, UISearchBarDelegate {
    let homeViewModel:HomeViewModel
    private var cancellables = Set<AnyCancellable>()
    var dataSource: UICollectionViewDiffableDataSource<ProductSection, Product>!
    var filteredProducts: [Product] = []

    let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 100, height: 120)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    let productList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 240)
        layout.sectionInset = UIEdgeInsets(top: 25, left: 0, bottom: 4, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()

    
    lazy var homeView = HomeView(
        categoriesCollectionView: categoriesCollectionView,
        productList: productList
    )
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(languageDidChange),
                name: .appLanguageDidChange,
                object: nil
            )
        setupProductDataSource()
        setupCollectionViews()
        setupActions()
        observeViewModel()
        setupFavoriteSubscriptions()
        homeViewModel.fetchHomeData()
        setupFavoriteNotifications()
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
        homeView.searchBar.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(CategoryCell.self, 
                                          forCellWithReuseIdentifier: CategoryCell.identifier)
        productList.dataSource = dataSource
        productList.delegate = self
        productList.register(ProductCell.self,
                             forCellWithReuseIdentifier: ProductCell.identifier)
        productList.isScrollEnabled = true
        productList.alwaysBounceVertical = true
        categoriesCollectionView.configureScrolling(hidesIndicators: true, enablesScroll: true)
        productList.configureScrolling(hidesIndicators: true, enablesScroll: true)
    }

    func updateSelectedIndex(_ index: Int) {
        homeView.selectedIndex = index
        homeView.updateUnderlinePosition()
    }
    
    
    private func setupActions() {
        homeView.onCompaniesTapped = { [weak self] in
            self?.homeViewModel.navigateToCompanies()
        }
    }
    
    private func observeViewModel() {
        homeViewModel.$newArrivals
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newProducts in
                guard let self = self else { return }
                self.filteredProducts = newProducts
                self.applySnapshot(with: newProducts)
            }
            .store(in: &cancellables)

        homeViewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.categoriesCollectionView.reloadData()
            }
            .store(in: &cancellables)
        if let token = KeychainManager.shared.getToken() {
            print("Token home: \(token)")
        } else {
            print("Token tapılmadı")
        }
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
    
    private func setupProductDataSource() {
           dataSource = UICollectionViewDiffableDataSource<ProductSection, Product>(collectionView: productList) { [weak self] collectionView, indexPath, product -> UICollectionViewCell? in
               guard let self = self else { return nil }
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
               cell.configure(with: product)
               cell.onFavoriteTapped = {
                   self.homeViewModel.toggleFavorite(for: product.id) { success in
                       DispatchQueue.main.async {
                           if success {
                               self.applySnapshot(with: self.filteredProducts)
                           }
                       }
                   }
               }
               return cell
           }
       }

       private func applySnapshot(with products: [Product]) {
           var snapshot = NSDiffableDataSourceSnapshot<ProductSection, Product>()
           snapshot.appendSections([.main])
           snapshot.appendItems(products, toSection: .main)
           dataSource.apply(snapshot, animatingDifferences: true)
       }

    func filterProducts(with query: String) {
        let currentOffset = productList.contentOffset
        if query.isEmpty {
            filteredProducts = homeViewModel.newArrivals
        } else {
            filteredProducts = homeViewModel.newArrivals.filter {
                $0.name.lowercased().contains(query.lowercased())
            }
        }
        print("Filtered count:", filteredProducts.count)
        applySnapshot(with: filteredProducts)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.productList.setContentOffset(currentOffset, animated: false)
        }
        if filteredProducts.count == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let indexPath = IndexPath(item: 0, section: 0)
                self.productList.scrollToItem(at: indexPath, at: .top, animated: true)
            }
        }
    }
  
    @objc
    private func languageDidChange() {
        updateTextsForCurrentLanguage()
    }

    func updateTextsForCurrentLanguage() {
        homeView.searchBar.placeholder = LocalizedStrings.searchBar
        homeView.homeButton.setTitle(LocalizedStrings.home, for: .normal)
        homeView.categoryButton.setTitle(LocalizedStrings.partners, for: .normal)
        homeView.headLabel.text = LocalizedStrings.products
        homeView.companyHeadLabel.text = LocalizedStrings.companyHead
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
