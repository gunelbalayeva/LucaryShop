//
//  CartViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
import Combine
final class CartViewController:UIViewController {
    let cartView = CartView()
    let viewModel:CartViewModel
    private var cancellables = Set<AnyCancellable>()
    
    
    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = cartView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .verifyBg
        title = "Səbətim"
        setupNavigationBar()
        setupTableView()
        showLoading()
        bindViewModel()
        viewModel.fetchCart()
    }
    
    private func setupTableView() {
        cartView.tableView.dataSource = self
        cartView.tableView.delegate = self
    }
    
    private var currentItemIDs: [String] = []
    
    private func bindViewModel() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                isLoading ? self?.showLoading() : self?.hideLoading()
            }
            .store(in: &cancellables)
        viewModel.$cartItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.cartView.tableView.reloadData()
            }
            .store(in: &cancellables)
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let message = errorMessage else { return }
                self?.showErrorAlert(message: message)
            }
            .store(in: &cancellables)
    }
    
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Xəta", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
    private func updateVisibleCellsQuantities() {
        guard let visibleIndexPaths = cartView.tableView.indexPathsForVisibleRows else { return }
        for indexPath in visibleIndexPaths {
            if indexPath.row < viewModel.cartItems.count,
               let cell = cartView.tableView.cellForRow(at: indexPath) as? CartCell {
                let item = viewModel.cartItems[indexPath.row]
                cell.updateQuantity(item.quantity)
                cell.updatePrice(item.price * Double(item.quantity))
            }
        }
    }
    
    private func setupNavigationBar() {
        let config = UIImage.SymbolConfiguration(weight: .heavy)
        let image = UIImage(systemName: "chevron.backward", withConfiguration: config)
        let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .darkGray
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func showLoading() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.tag = 999
        let loadingView = UIView()
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        loadingView.frame = view.bounds
        loadingView.tag = 1000
        view.addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        activityIndicator.center = loadingView.center
    }

    private func hideLoading() {
        view.viewWithTag(1000)?.removeFromSuperview()
        view.viewWithTag(999)?.removeFromSuperview()
    }
}
