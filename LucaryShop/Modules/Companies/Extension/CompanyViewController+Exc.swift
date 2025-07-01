//
//  CompanyViewController+Exc.swift
//  LucaryShop
//
//  Created by User on 26.06.25.
//

import UIKit
extension CompanyViewController :UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let company = dataSource.itemIdentifier(for: indexPath) {
            viewModel.coordinator?.navigateToCompaniesDetail(companyId: company.id)
        }
    }
}


extension CompanyViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCompanies = viewModel.companies
        } else {
            filteredCompanies = viewModel.companies.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        applySnapshot(companies: filteredCompanies)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
