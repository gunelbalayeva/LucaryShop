//
//  CategoriesDetail+Exc.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import UIKit
extension CategoriesDetailViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = categoriesDetailView.categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoriesDetailCell.identifier, for: indexPath) as? CategoriesDetailCell {
            let product = viewModel.products[indexPath.item]
            cell.configure(with: product)
            print("Product",product)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = viewModel.products[indexPath.item]
        print("selectedProductId: \(selectedProduct.id)")
        viewModel.coordinator?.navigateToProductDetail(productId: selectedProduct.id)
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                           layout collectionViewLayout: UICollectionViewLayout,
//                           sizeForItemAt indexPath: IndexPath) -> CGSize {
//           return CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 240)
//       }
}
