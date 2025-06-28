//
//  OrdersView.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import UIKit
final class OrdersView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(OrderCell.self, forCellReuseIdentifier: OrderCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    private func setupUI() {
        backgroundColor = .verifyBg
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
