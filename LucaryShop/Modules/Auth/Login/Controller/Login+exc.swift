//
//  Login+exc.swift
//  LucaryShop
//
//  Created by User on 17.06.25.
//

import UIKit

extension LoginViewController {
    
    func validateInput(email: String, password: String) -> Bool {
           guard !email.isEmpty && !password.isEmpty else {
               showError("Enter your email and password")
               return false
           }
           guard InputSanitizer.isValidEmail(email) else {
               showError("Enter a valid email address (for example: name@example.com)")
               return false
           }
           guard InputSanitizer.isValidPassword(password) else {
               showError("The password must be at least 6 characters long and contain both letters and numbers.")
               return false
           }
           return true
       }
}
