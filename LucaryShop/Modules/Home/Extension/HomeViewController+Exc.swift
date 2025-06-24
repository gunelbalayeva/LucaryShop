//
//  HomeViewController+Exc.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == companiesCollectionView {
            return homeViewModel.companies.count
        } else if collectionView == productList {
            return homeViewModel.newArrivals.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == companiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyCell.identifier, for: indexPath) as! CompanyCell
            // cell.configure(...)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
            let product = homeViewModel.newArrivals[indexPath.item]
            cell.configure(with: product)
            return cell
        }
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productList {
            let selectedProduct = homeViewModel.newArrivals[indexPath.item]
            homeViewModel.coordinator?.navigateToProductDetail(productId: selectedProduct.id)
        } else if collectionView == companiesCollectionView {
            print("Şirkət seçildi")
        }
    }
   
}
