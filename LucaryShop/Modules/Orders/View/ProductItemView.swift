//
//  ProductItemView.swift
//  LucaryShop
//
//  Created by User on 29.06.25.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

final class ProductItemView: UIView {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let quantityLabel = UILabel()
    
    init(product: CartItem) {
        super.init(frame: .zero)
        setupUI()
        configure(with: product)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.snp.makeConstraints { $0.size.equalTo(48) }

        nameLabel.font = .systemFont(ofSize: 14)
        quantityLabel.font = .systemFont(ofSize: 14)
        quantityLabel.textColor = .gray

        let infoStack = UIStackView(arrangedSubviews: [nameLabel, quantityLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 4

        let hStack = UIStackView(arrangedSubviews: [imageView, infoStack])
        hStack.axis = .horizontal
        hStack.spacing = 12

        addSubview(hStack)
        hStack.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func configure(with product: CartItem) {
        nameLabel.text = product.name
        quantityLabel.text = "\(LocalizedStrings.quantity): \(product.quantity)"
        
        if let url = URL(string: product.imgUrl) {
            imageView.kf.setImage(with: url)
        }
    }
}
