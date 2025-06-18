//
//  InputSanitizer.swift
//  LucaryShop
//
//  Created by User on 18.06.25.
//

import Foundation
final class InputSanitizer {
    private init() {}
    
    static func trimmed(_ text: String?) -> String {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    
    static func containsWhitespace(_ text: String?) -> Bool {
        return text?.contains(" ") ?? false
    }
    
    static func isValidPassword(_ password: String?) -> Bool {
        let trimmed = trimmed(password)
        return trimmed.count >= 6 &&
        trimmed.rangeOfCharacter(from: .decimalDigits) != nil &&
        trimmed.rangeOfCharacter(from: .letters) != nil
    }
    
    static func isValidEmail(_ email: String?) -> Bool {
            guard let email = email else { return false }
            let trimmed = trimmed(email)
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: trimmed)
        }
}
