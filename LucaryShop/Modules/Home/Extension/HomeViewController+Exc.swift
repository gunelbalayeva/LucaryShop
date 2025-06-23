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
            let company = homeViewModel.companies[indexPath.item]
//            cell.configure(with: company)
            return cell
        } else if collectionView == productList {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
            let product = homeViewModel.newArrivals[indexPath.item]
            cell.configure(with: product)
            return cell
        }
        
        return UICollectionViewCell()
    }

}
