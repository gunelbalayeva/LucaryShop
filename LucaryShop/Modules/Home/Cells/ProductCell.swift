//
//  ProductCell.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
import Kingfisher
protocol ProductCellDelegate: AnyObject {
    func productCell(_ cell: ProductCell, didToggleFavoriteFor product: Product)
    func productCell(_ cell: ProductCell, didSelect product: Product)
}


final class ProductCell: UICollectionViewCell {
    
    weak var delegate: ProductCellDelegate?
    private var currentProduct: Product?
       private var isFavorite: Bool = false
    
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
        label.textColor = UIColor(named: "priceColor")
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()

    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
    }

    @objc private func cellTapped() {
        if let product = currentProduct {
            delegate?.productCell(self, didSelect: product)
        }
    }
    
    func configure(with product: Product) {
        currentProduct = product
        isFavorite = product.favorite
        nameLabel.text = product.name
        priceLabel.text = "\(product.price) ₼"
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
        isFavorite.toggle()
        updateFavoriteIcon(isFavorite: isFavorite)

        if var product = currentProduct {
            product.favorite = isFavorite
            delegate?.productCell(self, didToggleFavoriteFor: product)
        }

        print("Favori statusu: \(isFavorite)")
    }

    

}
