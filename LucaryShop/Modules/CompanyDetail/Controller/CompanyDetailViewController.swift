//
//  CompanyDetailViewController.swift
//  LucaryShop
//
//  Created by User on 21.06.25.
//

import Foundation
import UIKit
import Combine
final class CompanyDetailViewController:UIViewController {
    var companyView = CompanyDetailView()
    let viewModel: CompanyDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: CompanyDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        self.view = companyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        call()
        bind()
        viewModel.fetchCompanyDetail()
        setupNavigationBar()
    }
    
    func call(){
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        companyView.companiesCollectionView.dataSource = self
        companyView.companiesCollectionView.delegate = self
        companyView.companiesCollectionView.register(CompanyDetailsCell.self, forCellWithReuseIdentifier: CompanyDetailsCell.identifier)
        
    }
    
    func bind() {
        viewModel.$companyDetail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] detail in
                if let name = detail?.name {
                    self?.companyView.configure(with: name)
                }
            }
            .store(in: &cancellables)

        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.companyView.companiesCollectionView.reloadData()
            }
            .store(in: &cancellables)
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
}
