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
    
    func isValidEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }

    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6 &&
            password.rangeOfCharacter(from: .decimalDigits) != nil &&
            password.rangeOfCharacter(from: .letters) != nil
    }

}
