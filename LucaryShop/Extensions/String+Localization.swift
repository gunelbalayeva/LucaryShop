//
//  String+Localization.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle.localized, comment: "")
    }
}
