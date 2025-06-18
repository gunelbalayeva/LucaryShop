//
//  LanguageController+Exc.swift
//  LucaryShop
//
//  Created by User on 18.06.25.
//

import UIKit

extension LanguageSelectionViewController :UITableViewDataSource ,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.identifier, for: indexPath) as? LanguageCell else {
            return UITableViewCell()
        }
        let language = viewModel.languages[indexPath.row]
        let isSelected = language == LocalizationManager.shared.currentLanguage
        cell.configure(language: language, isSelected: isSelected)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLanguage = viewModel.languages[indexPath.row]
        LocalizationManager.shared.currentLanguage = selectedLanguage
        tableView.reloadData()
    }
}



