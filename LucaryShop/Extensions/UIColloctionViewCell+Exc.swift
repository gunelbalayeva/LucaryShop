//
//  UIColloctionViewCell+Exc.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import UIKit
extension UICollectionViewCell {
    static var identifier:String {
        String(describing: self)
    }
    
    static var nib :UINib {
        return UINib(nibName: self.identifier, bundle: .main)
    }
}
