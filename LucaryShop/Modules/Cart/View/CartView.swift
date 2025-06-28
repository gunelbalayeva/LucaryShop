//
//  CartView.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import UIKit
final class CartView: UIView {
    var onConfirmTapped: (() -> Void)?
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let sumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.text = "Cəmi:"
        return label
    }()
    
    private let sumPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.text = "0 AZN"
        return label
    }()
    
    private let confirmCartButton: CustomButton = {
        let button = CustomButton(style: .filled, height: 48, width: 200)
        button.setTitle("Səbəti təsdiqlə", for: .normal)
        return button
    }()
    
    private lazy var sumStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sumNameLabel, sumPriceLabel])
        stack.axis = .vertical
        stack.backgroundColor = .clear
        stack.spacing = 4
        return stack
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sumStackView, confirmCartButton])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.backgroundColor = .clear
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
      
    override init(frame: CGRect) {
        super.init(frame: frame)
        confirmCartButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        setupUI()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews(views: tableView, bottomStackView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(bottomStackView.snp.top)
        }
        bottomStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(80)
            make.height.equalTo(80)
        }
    }
    
    func getTableView() -> UITableView {
        return tableView
    }
    
    
    @objc
    private func confirmButtonTapped() {
        onConfirmTapped?()
    }
    
    func setTotalPriceText(_ value: Double) {
        let formatted = String(format: "%.2f AZN", value)
        sumPriceLabel.text = formatted
    }
}
