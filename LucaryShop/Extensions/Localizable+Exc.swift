//
//  Localizable+Exc.swift
//  LucaryShop
//
//  Created by User on 18.06.25.
//

import Foundation
import UIKit

protocol Localizable: AnyObject {
    func updateTexts()
}

extension Localizable where Self: UIViewController {
    func observeLanguageChanges() {
        NotificationCenter.default.addObserver(forName: .appLanguageDidChange, object: nil, queue: .main) { [weak self] _ in
            self?.updateTexts()
        }
    }
}
