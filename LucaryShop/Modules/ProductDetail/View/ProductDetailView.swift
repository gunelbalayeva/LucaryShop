//
//  ProductDetailView.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import UIKit
import SnapKit
final class ProductDetailView: UIView {
    var onFavoriteTapped: (() -> Void)?
    var onAddToCartTapped: (() -> Void)?
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.layer.cornerRadius = 30
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel :UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "35 AZN"
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textColor = UIColor(named: "priceColor")
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    
    private let addToCartButton: CustomButton = {
        let button = CustomButton(style: .filled)
        button.setTitle("Sebete elave et", for: .normal)
        return button
    }()
    
    
    private let goToCartButton: CustomButton = {
        let button = CustomButton(style: .outlined)
        button.setTitle("Səbətə bax", for: .normal)
        return button
    }()
    
    
    private var isFavorite: Bool = false
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        addSubviews(views: imageView, scrollView)
        scrollView.addSubview(contentStack)
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(460)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        contentStack.configure(axis: .vertical, alignment: .fill, spacing: 16)
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
            $0.width.equalTo(scrollView.snp.width).offset(-32)
        }
        let namePriceStack = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        namePriceStack.configure(axis: .vertical, alignment: .fill, spacing: 4)
        let topInfoStack = UIStackView(arrangedSubviews: [namePriceStack])
        topInfoStack.configure(axis: .horizontal, alignment: .center, spacing: 8)
        contentStack.addArrangedSubview(topInfoStack)
        favoriteButton.setSize(width: 40, height: 40)
        contentStack.addArrangedSubview(descriptionLabel)
        let buttonStack = UIStackView(arrangedSubviews: [addToCartButton, goToCartButton])
        buttonStack.configure(axis: .horizontal, alignment: .fill, spacing: 12)
        buttonStack.distribution = .fillEqually
        contentStack.addArrangedSubview(buttonStack)
        buttonStack.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        goToCartButton.addTarget(self, action: #selector(goToCartTapped), for: .touchUpInside)
    }
    
    
    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "\(product.price) ₼"
        descriptionLabel.text = product.description ?? ""
        isFavorite = product.favorite
        updateFavoriteIcon()
        if let imageUrlString = product.imgUrls?.first,
           let url = URL(string: imageUrlString) {
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "selectPhoto"))
        } else {
            imageView.image = UIImage(named: "selectPhoto")
        }
    }
    
    
    private func updateFavoriteIcon() {
        let imageName = isFavorite ? "heart.fill" : "heart.fill"
        if let image = UIImage(systemName: imageName) {
            favoriteButton.setImage(image, for: .normal)
            favoriteButton.backgroundColor = .clear
            favoriteButton.tintColor = isFavorite ? UIColor.red : UIColor.gray
        }
    }
    
    
    @objc
    func goToCartTapped(){
        print("Kart Funksiyasi islemir haaaa!")
    }
    
    @objc private func favoriteTapped() {
        onFavoriteTapped?()
    }
    
    @objc
    private func addToCartTapped() {
        onAddToCartTapped?()
    }
    
    func setFavorite(_ isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = isFavorite ? .red : .gray
    }
}
