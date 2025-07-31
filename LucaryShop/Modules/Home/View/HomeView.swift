//
//  HomeView.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//
import Foundation
import UIKit
import SnapKit
final class HomeView: UIView {
    var onCompaniesTapped: (() -> Void)?
    var productListTopToHeadLabel: Constraint?
    var productListTopToSearchBar: Constraint?
    private let fixedHeaderView = UIView()
    private let contentView = UIView()
    let categoriesCollectionView: UICollectionView
    let productList: UICollectionView
    let headerLogoName: UILabel = {
        let label = UILabel()
        label.text = "Lucary"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(named: "logoColor")
        return label
    }()
    
    let menyuButton: CustomButton = {
        let button = CustomButton(style: .plain)
//        button.setImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
//        button.tintColor = .onboardingLabel
        return button
    }()
    
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Axtar"
        bar.searchTextField.backgroundColor = .white
        bar.searchTextField.layer.cornerRadius = 12
        bar.searchTextField.clipsToBounds = true
        bar.searchBarStyle = .minimal
        bar.tintColor = .black
        return bar
    }()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceVertical = true
        sv.isScrollEnabled = true
        return sv
    }()
    
    
    let bannerImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "banner")
        iv.layer.cornerRadius = 18
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let companyHeadLabel: UILabel = {
        let label = UILabel()
        label.text = "Kategoriyalar"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    
    let headLabel: UILabel = {
        let label = UILabel()
        label.text = "Məhsullar"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    init(categoriesCollectionView: UICollectionView, productList: UICollectionView) {
        self.categoriesCollectionView = categoriesCollectionView
        self.productList = productList
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        fixedHeaderView.backgroundColor = .white
        addSubview(fixedHeaderView)
        fixedHeaderView.addSubview(headerLogoName)
        fixedHeaderView.addSubview(menyuButton)
        fixedHeaderView.addSubview(searchBar)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(bannerImage)
        contentView.addSubview(companyHeadLabel)
        contentView.addSubview(categoriesCollectionView)
        contentView.addSubview(headLabel)
        contentView.addSubview(productList)
    }
    
    private func setupConstraints() {
        fixedHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.trailing.equalToSuperview()
        }

        
        headerLogoName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(searchBar.snp.top).offset(-16)
        }
        
        menyuButton.snp.makeConstraints { make in
            make.centerY.equalTo(headerLogoName)
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(44)
        }
        
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(44)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(fixedHeaderView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        bannerImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(154)
        }
        
        companyHeadLabel.snp.makeConstraints { make in
            make.top.equalTo(bannerImage.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(companyHeadLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        productList.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func setupActions() {
        menyuButton.addTarget(self, action: #selector(menyuButtonTapped), for: .touchUpInside)
    }
    
    @objc private func menyuButtonTapped() {
        
    }
    
    func updateProductListTopConstraint(hideHeader: Bool) {
        UIView.animate(withDuration: 0.3) {
            [self.bannerImage, self.companyHeadLabel,
             self.categoriesCollectionView,
             self.headLabel].forEach { view in
                view.isHidden = hideHeader
                view.alpha = hideHeader ? 0 : 1
            }
            
            self.productList.snp.remakeConstraints { make in
                if hideHeader {
                    make.top.equalTo(self.searchBar.snp.bottom).offset(16)
                } else {
                    make.top.equalTo(self.headLabel.snp.bottom).offset(8)
                }
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().offset(-16)
            }
            self.layoutIfNeeded()
        }
    }
}
