//
//  CartViewController+Exc.swift
//  LucaryShop
//
//  Created by User on 27.06.25.
//

import UIKit
extension CartViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.identifier, for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        let item = viewModel.cartItems[indexPath.row]
        cell.configure(with: item)
        cell.backgroundColor = .clear
        cell.onPlusTapped = { [weak self] in
            self?.viewModel.increaseQuantity(for: item.id)
        }

        cell.onMinusTapped = { [weak self] in
            self?.viewModel.decreaseQuantity(for: item.id)
        }
        
        cell.onDeleteTapped = { [weak self] in
            self?.viewModel.removeItemFromCart(with: item.id)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
