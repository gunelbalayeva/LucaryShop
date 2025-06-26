//
//  CompanyViewController+Exc.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import UIKit
extension CompanyViewController :UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.companies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = companyView.companiesCollectionView.dequeueReusableCell(withReuseIdentifier: CompanyCell.identifier, for: indexPath) as? CompanyCell {
            let companies = viewModel.companies[indexPath.item]
            cell.configure(with: companies)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = viewModel.companies[indexPath.item]
        print("selectedProductId: \(selectedProduct.id)")
        viewModel.coordinator?.navigateToCompaniesDetail(companyId: selectedProduct.id)
    }
    
}
