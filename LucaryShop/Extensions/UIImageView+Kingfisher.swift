//
//  UIImageView+Kingfisher.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String?) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            self.image = UIImage(named: "placeholder")
            return
        }
        self.kf.setImage(with: url)
    }
}
