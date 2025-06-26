//
//  FavoriteCell.swift
//  LucaryShop
//
//  Created by User on 25.06.25.
//

import UIKit
final class FavoriteCell:UICollectionViewCell {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 20
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.text = "35 AZN"
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    private var isFavorite: Bool = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupUI() {
        addSubviews(views: imageView, nameLabel, priceLabel, favoriteButton)
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
        favoriteButton.snp.makeConstraints { make in
            make.top.right.equalTo(imageView).inset(4)
            make.width.height.equalTo(30)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(4)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(0)
            make.left.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(3)
        }
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
    }
    
    
    var onFavoriteTapped: (() -> Void)?
    
    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "\(product.price) ₼"
        isFavorite = product.favorite
        updateFavoriteIcon(isFavorite: product.favorite)
        if let imageUrlString = product.imgUrl,
           let url = URL(string: imageUrlString) {
            imageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "selectPhoto"),
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ])
        } else {
            imageView.image = UIImage(named: "selectPhoto")
        }
    }
    
    private func updateFavoriteIcon(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart.fill"
        let tintColor = isFavorite ? .favoriteButton : UIColor.white
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = tintColor
    }
    
    
    @objc
    private func favoriteTapped() {
        onFavoriteTapped?()
    }
    
    
    func setFavorite(_ isFav: Bool) {
        self.isFavorite = isFav
        updateFavoriteIcon(isFavorite: isFav)
    }
}
