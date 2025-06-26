//
//  CategoriesDetailView.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import Foundation
import UIKit
final class CategoriesDetailView:UIView{
    let categoryNameLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .baseButton
       label.textAlignment = .center
       label.numberOfLines = 0
       return label
   }()
    
    let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 240)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
        
    override init(frame: CGRect) {
           super.init(frame: frame)
           setupUI()
        setupConstraints()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
    private func setupUI() {
        backgroundColor = .systemBackground
        addSubview(categoryNameLabel)
        addSubview(categoriesCollectionView)
    }

    private func setupConstraints() {
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview().inset(16)
        }
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryNameLabel.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }

    func configure(with name: String) {
        categoryNameLabel.text = name
    }
}
