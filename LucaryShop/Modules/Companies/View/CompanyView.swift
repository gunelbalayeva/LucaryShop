//
//  CompanyView.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//

import UIKit
final class CompanyView: UIView{
    var onHomeTapped: (() -> Void)?
    var onCategoryTapped: (() -> Void)?
    let tabSwitcher = BaseTabSwitcherView()

    private var didSetInitialTab = false
    
    let companiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 150)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupActions()
        tabSwitcher.selectedIndex = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !didSetInitialTab {
            tabSwitcher.selectedIndex = 1
            didSetInitialTab = true
        }
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubviews(views: tabSwitcher)
        addSubviews(views: tabSwitcher, companiesCollectionView)
    }
    
    private func setupConstraints() {
        tabSwitcher.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.right.equalToSuperview().inset(16)
        }
        
        companiesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tabSwitcher.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview().inset(16)
        }
    }
    
    
    private func setupActions() {
        tabSwitcher.onHomeTapped = { [weak self] in
            self?.onHomeTapped?()
        }
        tabSwitcher.onCompanyTapped = { [weak self] in
            self?.onCategoryTapped?()
        }
    }
    
    func setSelectedTab(_ index: Int) {
        tabSwitcher.selectedIndex = index
    }
}
