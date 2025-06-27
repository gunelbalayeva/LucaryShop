//
//  CartView.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import UIKit
final class CartView: UIView {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func getTableView() -> UITableView {
        return tableView
    }
}
