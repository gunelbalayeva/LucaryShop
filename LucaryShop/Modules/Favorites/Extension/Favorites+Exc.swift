//
//  Favorites+Exc.swift
//  LucaryShop
//
//  Created by User on 25.06.25.
//

import UIKit
extension FavoritesViewViewController :UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell {
            let product = viewModel.favorites[indexPath.item]
            cell.configure(with: product)
            cell.onFavoriteTapped = { [weak self] in
                self?.viewModel.removeFavorite(productId: product.id) {
                    collectionView.reloadData()
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.favorites[indexPath.item]
        viewModel.fetchProductDetailAndNavigate(productId: product.id)
    }
    
    
}
