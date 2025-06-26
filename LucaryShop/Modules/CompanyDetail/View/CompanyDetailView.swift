//
//  CompanyDetailView.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//

import Foundation
import UIKit
final class CompanyDetailView: UIView {
    
     let companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "priceColor") ?? .label
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let companiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
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
        addSubview(companyNameLabel)
        addSubview(companiesCollectionView)
    }

    private func setupConstraints() {
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview().inset(16)
        }
        
        companiesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(companyNameLabel.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }

    func configure(with name: String) {
        companyNameLabel.text = name
    }
}
