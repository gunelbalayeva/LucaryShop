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

    
    func showBlurLoading() {
            let blurEffect = UIBlurEffect(style: .regular)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = view.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurView.tag = 777

            let indicator = UIActivityIndicatorView(style: .large)
            indicator.center = blurView.contentView.center
            indicator.startAnimating()
            blurView.contentView.addSubview(indicator)

            view.addSubview(blurView)
        }

        func hideBlurLoading() {
            view.viewWithTag(777)?.removeFromSuperview()
        }
}
