//
//  CompanyDetails+Exc.swift
//  LucaryShop
//
//  Created by User on 27.06.25.
//

import UIKit
extension CompanyDetailViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            viewModel.products.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let product = viewModel.products[indexPath.item]
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyDetailsCell.identifier, for: indexPath) as? CompanyDetailsCell {
                cell.configure(with: product)
                return cell
            }
            return UICollectionViewCell()
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = viewModel.products[indexPath.item]
        print("selectedProductId: \(selectedProduct.id)")
        viewModel.coordinator?.navigateToProductDetail(productId: selectedProduct.id)
    }
}
