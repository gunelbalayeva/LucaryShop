//
//  CategoryView+Exc.swift
//  LucaryShop
//
//  Created by User on 22.06.25.
//

import Foundation
import UIKit
extension CategoryViewController :UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as?
        CategoryCell {
           cell.backgroundColor = .bg
            return cell
        }
        return UITableViewCell()
    }
}
