//
//  ProductCell.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

final class ProductCell:UICollectionViewCell{
    private let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.layer.cornerRadius = 8
            return iv
        }()

        private let nameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            label.numberOfLines = 2
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
                make.height.equalTo(contentView.snp.width) // kvadrat şəkil
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

            if let imageUrlString = product.imgUrls.first, let url = URL(string: imageUrlString) {
                print("Men ise dusdum")
                // Şəkili yükləmək üçün sadə üsul (bunu real layihədə Kingfisher, SDWebImage ilə et)
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: data)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(systemName: "photo") // fallback şəkil
                        }
                    }
                }
            } else {
                imageView.image = UIImage(systemName: "photo") // fallback şəkil
            }
        }
}
