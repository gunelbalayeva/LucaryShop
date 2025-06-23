//
//  CategoryViewController.swift
//  LucaryShop
//
//  Created by User on 19.06.25.
//

import Foundation
import UIKit
final class CategoryViewController:UIViewController {
    private let tableView = UITableView()
      private lazy var categoryView = CategoryView(tableView: tableView)
      private let viewModel: CategoryViewModel

      init(viewModel: CategoryViewModel) {
          self.viewModel = viewModel
          super.init(nibName: nil, bundle: nil)
      }

      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        categoryView.tabSwitcher.selectedIndex = 1
        categoryView.tabSwitcher.updateUnderlinePosition(animated: false)
    }

    
      override func loadView() {
          self.view = categoryView
      }
    
      override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = .systemBackground
          navigationItem.hidesBackButton = true
          setupTableView()
          setupActions()
      }

     

      private func setupTableView() {
          tableView.dataSource = self
          tableView.delegate = self
          tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
      }

    
      private func setupActions() {
          categoryView.onHomeTapped = { [weak self] in
              self?.navigateToHome()
          }
          categoryView.onCategoryTapped = {
              print("Category səhifəsi aktivdir")
          }
      }

      private func navigateToHome() {
          if let coordinator = viewModel.coordinator {
              coordinator.navigateToHome()
          } else {
              print("Coordinator tapılmadı")
          }
      }
}
