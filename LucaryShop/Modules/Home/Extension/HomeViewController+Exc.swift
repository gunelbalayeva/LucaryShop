//
//  HomeViewController+Exc.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//

import UIKit

extension HomeViewController :UICollectionViewDataSource,
                              UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == companiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyCell.identifier, for: indexPath)
            cell.backgroundColor = .systemGreen
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath)
            cell.backgroundColor = .systemOrange
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == productList else { return }
        let offsetY = scrollView.contentOffset.y
        let threshold: CGFloat = 10
        let shouldHideHeader = offsetY > threshold
        homeView.updateProductListTopConstraint(hideHeader: shouldHideHeader)
    }
}
