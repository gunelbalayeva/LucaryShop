//
//  KeychainManager.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import Foundation
import Security
final class KeychainManager {
    static let shared = KeychainManager()
      private init() {}
      func save(token: String, for key: String = "jwtToken") {
          guard let data = token.data(using: .utf8) else { return }

          let query: [String: Any] = [
              kSecClass as String: kSecClassGenericPassword,
              kSecAttrAccount as String: key,
              kSecValueData as String: data
          ]

          SecItemDelete(query as CFDictionary)
          SecItemAdd(query as CFDictionary, nil)
      }

      func getToken(for key: String = "jwtToken") -> String? {
          let query: [String: Any] = [
              kSecClass as String: kSecClassGenericPassword,
              kSecAttrAccount as String: key,
              kSecReturnData as String: true,
              kSecMatchLimit as String: kSecMatchLimitOne
          ]

          var dataTypeRef: AnyObject?
          let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

          guard status == errSecSuccess,
                let data = dataTypeRef as? Data,
                let token = String(data: data, encoding: .utf8) else {
              return nil
          }

          return token
      }

      func deleteToken(for key: String = "jwtToken") {
          let query: [String: Any] = [
              kSecClass as String: kSecClassGenericPassword,
              kSecAttrAccount as String: key
          ]

          SecItemDelete(query as CFDictionary)
      }
}
