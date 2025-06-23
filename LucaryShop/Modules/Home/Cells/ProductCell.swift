//
//  ProductCell.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
import UIKit
import Kingfisher

final class ProductCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemGreen
        return label
    }()
    
    private let favoriteIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "heart.fill")
        iv.tintColor = .systemRed
        iv.isHidden = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(favoriteIcon)
        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(4)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(4)
        }
        
        favoriteIcon.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(4)
            make.width.height.equalTo(16)
        }
    }
    
    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "\(product.price) ₼"
        favoriteIcon.isHidden = !product.favorite

        if let imageUrlString = product.imgUrl,
           let url = URL(string: imageUrlString) {
            imageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo"),
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ])
        } else {
            imageView.image = UIImage(systemName: "photo")
        }

        print("Şəkil linki: \(product.imgUrl ?? "yoxdur")")
    }    
}
