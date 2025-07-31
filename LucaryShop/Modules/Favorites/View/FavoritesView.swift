//
//  FavoritesView.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import UIKit

final class FavoritesView:UIView{
    
     var headerLabel:UILabel = {
        var label =  UILabel().withStyle(text: "Sevimlilər", size: 16)
        label.font =  UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    private let favoriteCollectionView: UICollectionView
    
    init(favoriteCollectionView: UICollectionView) {
        self.favoriteCollectionView = favoriteCollectionView
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubviews(views: headerLabel, favoriteCollectionView)
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview().inset(16)
        }
        
        favoriteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(0)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
