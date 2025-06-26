//
//  CompanyDetailsCell.swift
//  LucaryShop
//
//  Created by User on 27.06.25.
//

import Foundation
import UIKit
final class CompanyDetailsCell:UICollectionViewCell {
    private let imageView: UIImageView = {
           let iv = UIImageView()
           iv.contentMode = .scaleAspectFill
           iv.clipsToBounds = true
           iv.layer.cornerRadius = 12
           return iv
       }()
       
       private let nameLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
           label.textColor = UIColor(named: "priceColor") ?? .label
           label.textAlignment = .center
           label.numberOfLines = 2
           return label
       }()
       
       private let priceLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
           label.textColor = .systemGray
           label.textAlignment = .center
           return label
       }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           contentView.backgroundColor = .verifyBg
           contentView.layer.cornerRadius = 20
           contentView.clipsToBounds = true
           setupUI()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       private func setupUI() {
           [imageView, nameLabel, priceLabel].forEach { contentView.addSubview($0) }
           
           imageView.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(8)
               make.centerX.equalToSuperview()
               make.width.height.equalTo(100)
           }
           
           nameLabel.snp.makeConstraints { make in
               make.top.equalTo(imageView.snp.bottom).offset(8)
               make.left.right.equalToSuperview().inset(8)
           }
           
           priceLabel.snp.makeConstraints { make in
               make.top.equalTo(nameLabel.snp.bottom).offset(4)
               make.left.right.equalToSuperview().inset(8)
               make.bottom.lessThanOrEqualToSuperview().inset(8)
           }
       }
       
       func configure(with product: Product) {
           nameLabel.text = product.name
           priceLabel.text = "\(product.price) ₼"
           
           if let imgUrl = product.imgUrl, let url = URL(string: imgUrl) {
               imageView.kf.setImage(with: url,
                                     placeholder: UIImage(named: "selectPhoto"),
                                     options: [.transition(.fade(0.3)), .cacheOriginalImage])
           } else {
               imageView.image = UIImage(named: "selectPhoto")
           }
       }
}
