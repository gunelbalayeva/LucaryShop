//
//  ViewController+exc.swift
//  LucaryShop
//
//  Created by User on 17.06.25.
//

import UIKit

extension UIViewController {
    func showError(_ message: String) {
           let alert = UIAlertController(title: "Xəta", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
}
