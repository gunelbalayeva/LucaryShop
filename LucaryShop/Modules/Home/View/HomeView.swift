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
    var onCategoriesTapped: (() -> Void)?
    
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
        button.tintColor = .onboardingLabel
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
    
    let bannerImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "banner")
        iv.layer.cornerRadius = 18
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let headLabel:UILabel = {
        let label = UILabel().withStyle(text: "Məhsullar", size: 16)
        label.font =  UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let companyHeadLabel: UILabel = {
      let label =  UILabel().withStyle(text: "Partnyorlarımız", size: 16)
        label.font =  UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let companySeeAllButton: CustomButton = {
        let button = CustomButton(style: .plain)
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    lazy var companyStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [companyHeadLabel, companySeeAllButton])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    lazy var headerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerLogoName, menyuButton])
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()

    let companiesCollectionView: UICollectionView
    private let productList: UICollectionView
    private var productListTopConstraint: Constraint?
    
    
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
    
    
    private func setupUI() {
        backgroundColor = .white
        updateUnderlinePosition()
        addSubviews(views: headerStackView, searchBar, buttonStackView, underlineView, bannerImage, companyStackView, companiesCollectionView, headLabel, productList)
        companyHeadLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        companyHeadLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func setupConstraints() {
        headerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.right.equalToSuperview().inset(16)
        }
        
        menyuButton.setSize(width: 55, height: 50)
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
            make.top.equalTo(companyStackView.snp.bottom).offset(0)
            make.left.right.equalToSuperview().inset(0)
            make.height.equalTo(120)
        }
        
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(companiesCollectionView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        productList.snp.makeConstraints { make in
            productListTopConstraint = make.top.equalTo(headLabel.snp.bottom).offset(16).constraint
            make.left.right.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func setupActions() {
        menyuButton.addTarget(self, action: #selector(menyuButtonTapped), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        companySeeAllButton.addTarget(self, action: #selector(companySeeAllTapped), for: .touchUpInside)
    }
    
     var selectedIndex: Int = 0
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        let isHome = sender == homeButton
        selectedIndex = isHome ? 0 : 1
        
        if !isHome {
            onCategoriesTapped?()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUnderlinePosition()
    }

    func updateUnderlinePosition(animated: Bool = true) {
        let targetX = selectedIndex == 0 ? 0 : buttonStackView.frame.width / 2
        underlineLeadingConstraint?.update(offset: targetX)
        
        homeButton.alpha = selectedIndex == 0 ? 1.0 : 0.5
        categoryButton.alpha = selectedIndex == 0 ? 0.5 : 1.0
        
        let animations = {
            self.layoutIfNeeded()
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: animations)
        } else {
            animations()
        }
    }



    
    @objc
    private func companySeeAllTapped() {
        print("Sirketlere bax")
        // Delegate pattern ile
    }
    
    @objc
    private func menyuButtonTapped(){
        print("Menyu gosterilir")
    }
    
    @objc
    private func categoryButtonTapped(){
        onCategoriesTapped?()
        print("Category sehifesi gosterilir")
    }
    
    func updateProductListTopConstraint(hideHeader: Bool) {
        UIView.animate(withDuration: 0.3) {
            [self.bannerImage, self.companyStackView, self.companiesCollectionView, self.headLabel].forEach { view in
                view.alpha = hideHeader ? 0 : 1
            }
            self.productListTopConstraint?.deactivate()
            self.productList.snp.makeConstraints { make in
                if hideHeader {
                    self.productListTopConstraint = make.top.equalTo(self.buttonStackView.snp.bottom).constraint
                } else {
                    self.productListTopConstraint = make.top.equalTo(self.headLabel.snp.bottom).offset(16).constraint
                }
            }
            self.layoutIfNeeded()
        }
    }
    
}

extension HomeView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == productList else { return }
        let offsetY = scrollView.contentOffset.y
        let threshold: CGFloat = 10
        let shouldHide = offsetY > threshold
        
        [bannerImage, companyStackView, companiesCollectionView, headLabel].forEach { view in
            view.isHidden = shouldHide
        }
        productListTopConstraint?.deactivate()
        productList.snp.updateConstraints { make in
            if shouldHide {
                productListTopConstraint = make.top.equalTo(buttonStackView.snp.bottom).constraint
            } else {
                productListTopConstraint = make.top.equalTo(headLabel.snp.bottom).offset(16).constraint
            }
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
