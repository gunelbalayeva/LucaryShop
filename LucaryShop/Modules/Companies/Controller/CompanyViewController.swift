//
//  CompanyViewController.swift
//  LucaryShop
//
//  Created by User on 20.06.25.
//
import Foundation
import UIKit
import Combine

final class CompanyViewController: UIViewController {
    let companyView = CompanyView()
    let viewModel: CompanyViewModel
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        call()
        binding()
    }

    override func loadView() {
        self.view = companyView
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            viewModel.coordinator?.finish()
        }
    }

    init(viewModel: CompanyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func call(){
        companyView.companiesCollectionView.dataSource = self
        companyView.companiesCollectionView.delegate = self
        companyView.companiesCollectionView.register(CompanyCell.self, forCellWithReuseIdentifier: CompanyCell.identifier)

        companyView.onHomeTapped = { [weak self] in
            self?.viewModel.coordinator?.finish()
            self?.navigationController?.popViewController(animated: true)
        }
    }

    func binding() {
        viewModel.fetchCompanies()
        viewModel.$companies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.companyView.companiesCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

