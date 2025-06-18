//
//  CollectionView+Exc.swift
//  LucaryShop
//
//  Created by User on 18.06.25.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var identifier:String {
        String(describing: self)
    }
    
    static var nib :UINib {
        return UINib(nibName: self.identifier, bundle: .main)
    }
}
