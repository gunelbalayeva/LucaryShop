//
//  ProductDetailViewController.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//

import UIKit
import Combine
final class ProductDetailViewController:UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    private let productDetailView = ProductDetailView()
    private let viewModel:ProductDetailViewModel
    var product: Product?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        viewModel.fetchProductDetail()
        bindViewModel()
        setupActions()
    }
    
    override func loadView() {
        self.view = productDetailView
    }
    
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationBar() {
        let config = UIImage.SymbolConfiguration(weight: .heavy)
        let image = UIImage(systemName: "chevron.backward", withConfiguration: config)
        let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .darkGray
        navigationItem.leftBarButtonItem = backButton
    }
    
    
    private func bindViewModel() {
           viewModel.$product
               .receive(on: DispatchQueue.main)
               .sink { [weak self] product in
                   guard let product = product else { return }
                   self?.productDetailView.configure(with: product)
               }
               .store(in: &cancellables)

        viewModel.$isFavorite
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isFav in
                self?.productDetailView.setFavorite(isFav)
            }
            .store(in: &cancellables)


           viewModel.$errorMessage
               .compactMap { $0 }
               .receive(on: DispatchQueue.main)
               .sink { error in
                   print("Error: \(error)")
               }
               .store(in: &cancellables)
       }

    
       private func setupActions() {
           productDetailView.onFavoriteTapped = { [weak self] in
               self?.viewModel.toggleFavorite()
           }

           productDetailView.onAddToCartTapped = { [weak self] in
               self?.viewModel.addToCart()
           }
       }
    
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    

}

