//
//  CollectionView+Exc.swift
//  LucaryShop
//
//  Created by User on 18.06.25.
//

import Foundation
import UIKit
extension UICollectionView {
    func configureScrolling(hidesIndicators: Bool = true, enablesScroll: Bool = true) {
        self.isScrollEnabled = enablesScroll
        if hidesIndicators {
            self.showsVerticalScrollIndicator = false
            self.showsHorizontalScrollIndicator = false
        } else {
            self.showsVerticalScrollIndicator = true
            self.showsHorizontalScrollIndicator = true
        }
    }
}
