//
//  BaseTabSwitcherView.swift
//  LucaryShop
//
//  Created by User on 22.06.25.
//

import Foundation
import UIKit
import SnapKit

final class BaseTabSwitcherView: UIView {
    
    var onHomeTapped: (() -> Void)?
    var onCompanyTapped: (() -> Void)?
    
    private let headerLogoName: UILabel = {
        let label = UILabel()
        label.text = "Lucary"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(named: "logoColor")
        return label
    }()
    
    private let menyuButton: CustomButton = {
        let button = CustomButton(style: .plain)
        //        let image = UIImage(systemName: "square.grid.2x2")
        //        button.setImage(image, for: .normal)
        //        button.tintColor = .onboardingLabel
        return button
    }()
    
     var searchBar: UISearchBar = {
        var bar = UISearchBar()
        bar.placeholder = "Axtar"
        bar.searchTextField.backgroundColor = .white
        bar.searchTextField.layer.cornerRadius = 8
        bar.searchTextField.clipsToBounds = true
        bar.searchBarStyle = .minimal
        bar.tintColor = .black
        bar.backgroundColor = .clear
        return bar
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "baseButton")
        return view
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerLogoName, menyuButton])
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()
    
    var underlineLeadingConstraint: Constraint?
    
    public var selectedIndex: Int = 0 {
        didSet {
            updateUnderlinePosition()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupActions()
        updateUnderlinePosition(animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUnderlinePosition(animated: false)
    }

    private func setupViews() {
       addSubviews(views: headerStackView, searchBar,underlineView)
    
    }
    
    private func setupConstraints() {
        headerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.right.equalToSuperview()
        }

        menyuButton.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(50)
        }

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(headerStackView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
    private func setupActions() {
//        homeButton.addTarget(self, action: #selector(homeTapped), for: .touchUpInside)
//        categoryButton.addTarget(self, action: #selector(categoryTapped), for: .touchUpInside)
    }
    
    @objc
    private func homeTapped() {
        selectedIndex = 0
        onHomeTapped?()
    }
    
    @objc
    private func categoryTapped() {
        selectedIndex = 1
        onCompanyTapped?()
    }
    
    func updateUnderlinePosition(animated: Bool = true) {
//        let offset = selectedIndex == 0 ? 0 : buttonStackView.frame.width / 2
//        underlineLeadingConstraint?.update(offset: offset)
//        
//        homeButton.alpha = selectedIndex == 0 ? 1.0 : 0.5
//        categoryButton.alpha = selectedIndex == 1 ? 1.0 : 0.5
//        
//        let animations = { self.layoutIfNeeded() }
//        
//        if animated {
//            UIView.animate(withDuration: 0.3, animations: animations)
//        } else {
//            animations()
//        }
    }
}
