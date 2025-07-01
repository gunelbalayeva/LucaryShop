//
//  HomeViewController+Exc.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == productList {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let frameHeight = scrollView.frame.size.height
            if offsetY > contentHeight - frameHeight * 1.5 {
                if let lastIndexPath = productList.indexPathsForVisibleItems.max() {
                    homeViewModel.loadNextPageIfNeeded(currentIndex: lastIndexPath.item)
                }
            }
            let shouldHide = offsetY > 10
            homeView.updateProductListTopConstraint(hideHeader: shouldHide)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            return homeViewModel.categories.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            let category = homeViewModel.categories[indexPath.item]
            cell.configure(with: category)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productList {
            if let product = dataSource.itemIdentifier(for: indexPath) {
                homeViewModel.coordinator?.navigateToProductDetail(productId: product.id)
            }
        } else if collectionView == categoriesCollectionView {
            let selectedCategory = homeViewModel.categories[indexPath.item]
            homeViewModel.coordinator?.navigateToCategoriesDetail(categoryId: selectedCategory.id)
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterProducts(with: searchText)
    }
}
