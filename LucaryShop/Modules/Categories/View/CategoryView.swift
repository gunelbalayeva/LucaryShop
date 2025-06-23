//
//  CategoryView.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import UIKit
import SnapKit
final class CategoryView:UIView{
    
    var onHomeTapped: (() -> Void)?
    var onCategoryTapped: (() -> Void)?

    let tableView: UITableView
    let tabSwitcher = BaseTabSwitcherView()
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        setupActions()
        tabSwitcher.selectedIndex = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubviews(views: tabSwitcher, tableView)
    }
    
    private func setupConstraints() {
            tabSwitcher.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.left.right.equalToSuperview().inset(16)
            }
            
            tableView.snp.makeConstraints { make in
                make.top.equalTo(tabSwitcher.snp.bottom).offset(16)
                make.left.right.bottom.equalToSuperview()
            }
        }
        
        private func setupActions() {
            tabSwitcher.onHomeTapped = { [weak self] in
                self?.onHomeTapped?()
            }
            tabSwitcher.onCategoryTapped = { [weak self] in
                self?.onCategoryTapped?()
            }
        }
        
        func setSelectedTab(_ index: Int) {
            tabSwitcher.selectedIndex = index
        }
}


