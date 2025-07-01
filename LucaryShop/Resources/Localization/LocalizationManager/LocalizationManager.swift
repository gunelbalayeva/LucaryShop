//
//  LocalizationManager.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
enum Language: String, CaseIterable {
case az, en, ru, tr

var title: String {
    switch self {
    case .az: return "Azərbaycan dili"
    case .en: return "English"
    case .ru: return "Русский"
    case .tr: return "Türkçe"
    }
}

var localeIdentifier: String {
    return self.rawValue
}
}

final class LocalizationManager {
    static let shared = LocalizationManager()
    private let languageKey = "selectedLanguage"
    
    private init() {}
    
    var currentLanguage: Language {
        get {
            if let saved = UserDefaults.standard.string(forKey: languageKey),
               let lang = Language(rawValue: saved) {
                return lang
            }
            return .az
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: languageKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: .appLanguageDidChange, object: nil)
        }
    }
    
    func localizedString(forKey key: String) -> String {
        guard let path = Bundle.main.path(forResource: currentLanguage.localeIdentifier, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return key
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}

private var associatedLanguageBundle: UInt8 = 0

extension Bundle {
    static var localized: Bundle {
        get {
            objc_sync_enter(Bundle.main)
            defer { objc_sync_exit(Bundle.main) }
            if let bundle = objc_getAssociatedObject(Bundle.main, &associatedLanguageBundle) as? Bundle {
                return bundle
            }
            return Bundle.main
        }
        set {
            objc_sync_enter(Bundle.main)
            defer { objc_sync_exit(Bundle.main) }
            objc_setAssociatedObject(Bundle.main, &associatedLanguageBundle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    static func setLanguage(_ languageCode: String) {
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            print("⚠️ Bundle tapılmadı: \(languageCode)")
            localized = .main
            return
        }
        localized = bundle
    }
}
