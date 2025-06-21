//
//  CompanyCell.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//

import UIKit
final class CompanyCell:UICollectionViewCell {
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            contentView.backgroundColor = .lightGray 
            contentView.layer.cornerRadius = contentView.frame.size.width / 2
            contentView.clipsToBounds = true
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            contentView.layer.cornerRadius = contentView.frame.size.width / 2
        }
}
