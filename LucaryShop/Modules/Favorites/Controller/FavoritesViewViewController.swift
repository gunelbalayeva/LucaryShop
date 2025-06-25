//
//  FavoritesViewViewController.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
import UIKit
final class FavoritesViewViewController:UIViewController{
    private let collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 240)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var favoriteView = FavoritesView(favoriteCollectionView: collectionview)
    let viewModel: FavoritesViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.identifier)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(favoritesDidChange),
                                               name: FavoritesService.favoritesDidChangeNotification,
                                               object: nil)
//        loadFavorites()
        
        if let token = KeychainManager.shared.getToken() {
            print("Token favorite: \(token)")
        } else {
            print("Token tapılmadı")
        }
    }
    
    
    override func loadView() {
        self.view = favoriteView
    }
    
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadFavorites(){
        viewModel.loadFavorites { [weak self] in
            self?.collectionview.reloadData()
        }
    }
    
    @objc
    private func favoritesDidChange() {
        loadFavorites()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
