//
//  ProductDetailView.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import UIKit
import SnapKit
final class ProductDetailView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    private func setupUI() {
        addSubview(imageView)
        let namePriceStack = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        namePriceStack.axis = .vertical
        namePriceStack.spacing = 4
        let topInfoStack = UIStackView(arrangedSubviews: [namePriceStack, favoriteButton])
        topInfoStack.axis = .horizontal
        topInfoStack.alignment = .center
        topInfoStack.spacing = 8
        addSubview(topInfoStack)
        addSubview(descriptionLabel)
        
        let buttonStack = UIStackView(arrangedSubviews: [addToCartButton, goToCartButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 12
        buttonStack.distribution = .fillEqually
        addSubview(buttonStack)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(460)
        }
        
        topInfoStack.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(topInfoStack.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        goToCartButton.addTarget(self, action: #selector(goToCartTapped), for: .touchUpInside)
    }

    
    
    
    
    func configure(with product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "\(product.price) ₼"
        isFavorite = product.favorite
        updateFavoriteIcon()
        
        if let imageUrlString = product.imgUrl,
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
    private func favoriteTapped() {
        isFavorite.toggle()
        updateFavoriteIcon()
        print("Favori statusu: \(isFavorite)")
        // Burada istəsən delegate/closure vasitəsilə məlumat ötür
    }
    
    @objc private func addToCartTapped() {
        print("Məhsul səbətə əlavə edildi")
        // Burada istəsən delegate/closure ilə səbətə əlavə et əmri ötür
    }
    
    @objc private func goToCartTapped() {
        print("Səbət səhifəsinə keçid")
        // Burada istəsən coordinator və ya closure vasitəsilə səbət səhifəsinə keçid et
    }
}
