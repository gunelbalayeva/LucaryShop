//
//  CartView.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import UIKit
final class CartView: UIView {

     let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.identifier)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        return tableView
    }()

    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "1"
        return label
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
            make.top.equalTo(200)
        }
    }

    func getTableView() -> UITableView {
        return tableView
    }
}
