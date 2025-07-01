//
//  LocalizedStrings.swift
//  LucaryShop
//
//  Created by User on 18.06.25.
//

import Foundation

enum LocalizedStrings {
    //Localized screen
    static var languageTitle: String { "language_title".localized }
    
    // Home screen
    static var searchBar :String {"search_bar".localized }
    static var home: String { "home".localized }
    static var partners: String {"partners".localized }
    static var products:String {"products".localized}
    static var companyHead: String {"company_head".localized}
    
    // Profile screen
    static var editedAccountButton:String { "editedAccount".localized }
    static var goToLanguageScreenButton :String{ "languageScreen".localized }
    static var goToOrdersButton:String{"orders".localized}
    static var goToAboutUsScreenButton:String {"aboutUsScreen".localized}
    static var goToTermsScreenButton :String {"termsScreen".localized}
    static var goToLogoutScreenButton:String {"logoutScreen".localized}
    
    static var logoutTitle: String { "logout_title".localized }
    static var logoutMessage: String { "logout_message".localized }
    static var logoutCancel: String { "logout_cancel".localized }
    static var logoutConfirm: String { "logout_confirm".localized }
    
    // Terms Screen
    static var termsText :String{"termsText".localized}
    static var termsTitle :String{ "terms_title".localized }
    
    //Companies
    static func productCount(_ count: Int) -> String {
        String(format: "product_count_format".localized, count)
    }

}
