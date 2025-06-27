//
//  CompanyCell.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import UIKit
final class CompanyCell:UICollectionViewCell {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.textColor = UIColor(named: "priceColor")
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let productCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.textColor = UIColor(named: "priceColor")
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .verifyBg
        contentView.layer.cornerRadius = 30
        contentView.clipsToBounds = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        [imageView, nameLabel, productCountLabel].forEach {
            contentView.addSubview($0)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        imageView.layer.cornerRadius = 40
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(4)
        }
        productCountLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(4)
            make.bottom.lessThanOrEqualToSuperview().inset(8)
        }
    }

    
    func configure(with company: Company) {
        nameLabel.text = company.name
        productCountLabel.text = "\(company.productCount) məhsul"
        
        if let url = URL(string: company.profileImage) {
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
}
