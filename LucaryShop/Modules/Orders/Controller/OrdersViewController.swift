//
//  OrdersViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
import Combine
final class OrdersViewController:UIViewController {
    let ordersView = OrdersView()
    let viewModel: OrdersViewModel
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        NotificationCenter.default.addObserver(self,
               selector: #selector(languageDidChange),
               name: .appLanguageDidChange,
               object: nil)
        title = "Sifarişlərim"
        setupTableView()
        binding()
        
    }
    
    init(viewModel: OrdersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = ordersView
    }
    
    private func setupTableView() {
        ordersView.tableView.dataSource = self
        ordersView.tableView.delegate = self
    }
    
    func binding() {
        viewModel.$orders
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.ordersView.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.showErrorAlert(message: message)
            }
            .store(in: &cancellables)
        
        viewModel.fetchOrders()
    }

   private func showErrorAlert(message: String) {
       let alert = UIAlertController(
           title: LocalizedStrings.errorTitle,
           message: message,
           preferredStyle: .alert
       )
       alert.addAction(UIAlertAction(title: LocalizedStrings.okButton, style: .default))
       present(alert, animated: true)
   }

      
    @objc
    private func languageDidChange() {
        updateTextsForCurrentLanguage()
    }

    func updateTextsForCurrentLanguage() {
        title = LocalizedStrings.orderHeader
    }
}
