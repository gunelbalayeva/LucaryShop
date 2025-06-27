//
//  CartCell.swift
//  LucaryShop
//
//  Created by User on 27.06.25.
//

import Foundation
import UIKit
final class CartCell: UITableViewCell {
    var onPlusTapped: (() -> Void)?
       var onMinusTapped: (() -> Void)?
       var onDeleteTapped: (() -> Void)?
        private let productImageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.layer.cornerRadius = 16
            return iv
        }()
        
        private let sellerNameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            label.textColor = .darkGray
            label.textAlignment = .left
            return label
        }()
        
        private let productNameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.textColor = UIColor(named: "priceColor")
            label.textAlignment = .left
            label.numberOfLines = 2
            return label
        }()
        
        private let productDescriptionLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            label.textColor = .gray
            label.textAlignment = .left
            label.numberOfLines = 2
            return label
        }()
        
        private let priceLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
            label.textColor = .baseButton
            label.textAlignment = .right
            return label
        }()
        
        private let plusButton: UIButton = {
            let button = UIButton()
            button.setTitle("+", for: .normal)
            button.setTitleColor(.baseButton, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
            return button
        }()
        
        private let minusButton: UIButton = {
            let button = UIButton()
            button.setTitle("-", for: .normal)
            button.setTitleColor(.baseButton, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
            return button
        }()
        
         let quantityLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
            label.textColor = .black
            label.textAlignment = .center
            return label
        }()
        
       
        private let deleteButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "trash"), for: .normal)
            button.tintColor = .baseButton
            return button
        }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(views: productImageView,
                                sellerNameLabel,productNameLabel,
                                priceLabel,deleteButton, quantityLabel,
                                plusButton,minusButton)
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(12)
            make.width.height.equalTo(100)
        }
        
        sellerNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(productImageView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(sellerNameLabel.snp.bottom).offset(4)
            make.left.equalTo(productImageView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).offset(4)
            make.left.equalTo(productImageView.snp.right).offset(12)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.width.height.equalTo(24)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.centerX.equalToSuperview()
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalTo(quantityLabel)
            make.left.equalTo(quantityLabel.snp.right).offset(8)
        }
        
        minusButton.snp.makeConstraints { make in
            make.centerY.equalTo(quantityLabel)
            make.right.equalTo(quantityLabel.snp.left).offset(-8)
        }
    }

    func configure(with item: CartItem) {
        productNameLabel.text = item.name
        updateQuantity(item.quantity)
        updatePrice(item.price * Double(item.quantity))
        
        if let url = URL(string: item.imgUrl) {
            productImageView.kf.setImage(with: url)
        }
    }
    
    private func setupActions() {
           plusButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
           minusButton.addTarget(self, action: #selector(didTapMinus), for: .touchUpInside)
           deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
       }
       
       @objc private func didTapPlus() {
           onPlusTapped?()
       }
       
       @objc private func didTapMinus() {
           onMinusTapped?()
       }
       
       @objc private func didTapDelete() {
           onDeleteTapped?()
       }
    
    func updateQuantity(_ quantity: Int) {
        quantityLabel.text = "\(quantity)"
    }

    func updatePrice(_ price: Double) {
        priceLabel.text = "\(Int(price)) ₼"
    }
    
}


