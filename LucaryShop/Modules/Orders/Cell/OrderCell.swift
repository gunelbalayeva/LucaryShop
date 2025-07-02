//
//  OrderCell.swift
//  LucaryShop
//
//  Created by User on 28.06.25.
//

import UIKit
import SnapKit
final class OrderCell: UITableViewCell {
     var dateHeaderLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textColor = UIColor(named: "blueColor") ?? .darkGray
        label.textAlignment = .left
        label.text = "Sifariş"
        label.text = LocalizedStrings.orderHeader
        return label
         
    }()
    
    private let dateLabel = UILabel().withStyle(text: "", size: 16)
    private let statusLabel = UILabel().withStyle(text: "", size: 16)
    private let priceLabel = UILabel().withStyle(text: "", size: 16)
    private let productCountLabel = UILabel().withStyle(text: "", size: 16)
    
    private let productsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            dateHeaderLabel,
            dateLabel,
            statusLabel,
            productCountLabel,
            priceLabel,
            productsStackView
        ])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        selectionStyle = .none

        contentView.addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func configure(with order: Order) {
        let formattedDate = String(order.date.prefix(10))
        dateLabel.text = "\(LocalizedStrings.orderDate) \(formattedDate)"
        statusLabel.text = "\(LocalizedStrings.orderStatus) \(order.status)"
        productCountLabel.text = "\(LocalizedStrings.orderProductCount) \(order.products.count)"
        priceLabel.text = String(format: LocalizedStrings.orderTotal, order.totalPrice)
        switch order.status.uppercased() {
        case "PENDING":
            statusLabel.textColor = .systemOrange
        case "COMPLETED":
            statusLabel.textColor = .systemGreen
        case "CANCELLED":
            statusLabel.textColor = .systemRed
        default:
            statusLabel.textColor = .darkGray
        }
        productsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }        
        order.products.forEach { product in
            let productView = ProductItemView(product: product)
            productsStackView.addArrangedSubview(productView)
        }
    }

}
