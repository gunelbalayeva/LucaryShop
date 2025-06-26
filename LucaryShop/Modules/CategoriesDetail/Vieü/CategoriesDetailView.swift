//
//  CategoriesDetailView.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import Foundation
import UIKit
final class CategoriesDetailView:UIView{
    let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 240)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
        
    override init(frame: CGRect) {
           super.init(frame: frame)
           setupUI()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
    func setupUI(){
        addSubview(categoriesCollectionView)
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
