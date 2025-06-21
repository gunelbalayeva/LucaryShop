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
    private let headerLogoName: UILabel = {
        let label = UILabel()
        label.text = "Lucary"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(named: "logoColor")
        return label
    }()
    
    private let menyuButton: CustomButton = {
        let button = CustomButton(style: .plain)
        let image = UIImage(systemName: "square.grid.2x2")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Axtar"
        bar.searchTextField.backgroundColor = .white
        bar.searchTextField.layer.cornerRadius = 8
        bar.searchTextField.clipsToBounds = true
        bar.searchBarStyle = .minimal
        bar.tintColor = .black
        bar.backgroundColor = .clear
        return bar
    }()
    
    private let homeButton: CustomButton = {
        let button = CustomButton(style: .plain)
        button.setTitle("Home", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.contentHorizontalAlignment = .center
        button.alpha = 1.0
        return button
    }()
    
    private let categoryButton: CustomButton = {
        let button = CustomButton(style: .plain)
        button.setTitle("Category", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.contentHorizontalAlignment = .center
        button.alpha = 0.5
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [homeButton, categoryButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "baseButton")
        return view
    }()
    
    private var underlineLeadingConstraint: Constraint?
    
    private let bannerImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "banner")
        iv.layer.cornerRadius = 18
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let headLabel = UILabel().withStyle(text: "Məhsullar", size: 16)
    private let companyHeadLabel = UILabel().withStyle(text: "Partnyorlarımız", size: 16)
    
    private let companySeeAllButton: CustomButton = {
        let button = CustomButton(style: .plain)
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private lazy var companyStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [companyHeadLabel, companySeeAllButton])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerLogoName, UIView(), menyuButton])
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()
    
    private let companiesCollectionView: UICollectionView
    private let productList: UICollectionView
    
    
    init(companiesCollectionView: UICollectionView, productList: UICollectionView) {
        self.companiesCollectionView = companiesCollectionView
        self.productList = productList
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .white
        addSubviews(views: headerStackView, searchBar, buttonStackView, underlineView, bannerImage, companyStackView, companiesCollectionView, headLabel, productList)
        companyHeadLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        companyHeadLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func setupConstraints() {
        headerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.right.equalToSuperview().inset(16)
        }
        
        menyuButton.setSize(width: 44, height: 44)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom)
            make.height.equalTo(2)
            make.width.equalTo(buttonStackView.snp.width).dividedBy(2)
            underlineLeadingConstraint = make.left.equalTo(buttonStackView.snp.left).constraint
        }
        
        bannerImage.snp.makeConstraints { make in
            make.top.equalTo(underlineView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(154)
        }
        
        companyStackView.snp.makeConstraints { make in
            make.top.equalTo(bannerImage.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        
        companiesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(companyStackView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
        
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(companiesCollectionView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        productList.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func setupActions() {
        homeButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        companySeeAllButton.addTarget(self, action: #selector(companySeeAllTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let isHome = sender == homeButton
        underlineLeadingConstraint?.deactivate()
        underlineView.snp.makeConstraints { make in
            underlineLeadingConstraint = make.left.equalTo(isHome ? buttonStackView.snp.left : buttonStackView.snp.centerX).constraint
            make.top.equalTo(buttonStackView.snp.bottom)
            make.height.equalTo(2)
            make.width.equalTo(buttonStackView.snp.width).dividedBy(2)
        }
        
        homeButton.alpha = isHome ? 1.0 : 0.5
        categoryButton.alpha = isHome ? 0.5 : 1.0
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func companySeeAllTapped() {
        print("Company See All tapped — navigate to companies page")
        // Coordinator və ya ViewController vasitəsilə səhifəyə keçid buraya əlavə olunacaq
    }
    
}
