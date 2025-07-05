//
//  CategoryCell.swift
//  LucaryShop
//
//  Created by User on 22.06.25.
//

import Foundation
import UIKit
final class CategoryCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    func configure(with category: Category) {
        nameLabel.text = category.name
        
        if let url = URL(string: category.imgUrl) {
            imageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "selectPhoto"),
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ]) { [weak self] _ in
                    self?.updateCornerRadius()
                }
        } else {
            imageView.image = UIImage(named: "selectPhoto")
            updateCornerRadius()
        }
    }
}

private extension CategoryCell {
    
    func setupViews() {
        [imageView, nameLabel].forEach {
            contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(64)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(4)
            make.bottom.lessThanOrEqualToSuperview().inset(8)
        }
    }
    
    func configureAppearance() {
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        updateCornerRadius()
    }
    
    func updateCornerRadius() {
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
            self.imageView.layer.masksToBounds = true
        }
    }
}
