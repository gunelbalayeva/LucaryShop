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
  
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    private func setupUI() {
        addSubview(imageView)
        addSubview(scrollView)
        scrollView.addSubview(contentStack)

        // imageView sabit yuxarıda
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(460)
        }

        // scrollView imageView-un altından başlasın
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }

        // contentStack scrollView-un içində
        contentStack.axis = .vertical
        contentStack.spacing = 16
        contentStack.alignment = .fill

        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
            make.width.equalTo(scrollView.snp.width).offset(-32)
        }

        let namePriceStack = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        namePriceStack.axis = .vertical
        namePriceStack.spacing = 4

        let topInfoStack = UIStackView(arrangedSubviews: [namePriceStack, favoriteButton])
        topInfoStack.axis = .horizontal
        topInfoStack.alignment = .center
        topInfoStack.spacing = 8

        contentStack.addArrangedSubview(topInfoStack)

        favoriteButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }

        contentStack.addArrangedSubview(descriptionLabel)

        let buttonStack = UIStackView(arrangedSubviews: [addToCartButton, goToCartButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 12
        buttonStack.distribution = .fillEqually

        contentStack.addArrangedSubview(buttonStack)
        buttonStack.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
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
    private func favoriteTapped() {
        isFavorite.toggle()
        updateFavoriteIcon()
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
